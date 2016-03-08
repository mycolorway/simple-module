gulp = require 'gulp'
ghPages = require 'gulp-gh-pages'
runSequence = require 'run-sequence'
fs = require 'fs'
pkg = require '../package.json'
helper = require './helper.coffee'

gulp.task 'publish.version', ->
  newVersion = helper.getReleaseVersion()
  unless newVersion
    throw new Error('Publish: Invalid version in CHANGELOG.md')
    return

  # if newVersion == pkg.version
  #   throw new Error('Publish: Missing new version info in CHANGELOG.md')
  #   return

  pkg.version = newVersion
  fs.writeFileSync './package.json', JSON.stringify(pkg, null, 2)

  bowerConfig = require '../bower.json'
  bowerConfig.version = newVersion
  fs.writeFileSync './bower.json', JSON.stringify(bowerConfig, null, 2)

gulp.task 'publish.docs', ->
  gulp.src '_docs/**/*'
    .pipe ghPages
      cacheDir: '.docs_publish_cache'
  helper.removeDir '.publish'

gulp.task 'publish.createRelease', ->
  try
    token = require '../.token.json'
  catch e
    throw new Error 'Publish: Need github access token for creating release.'
    return

  helper.createRelease token.github

gulp.task 'publish', ->
  runSequence 'publish.version', 'compile', 'test', 'publish.docs', 'publish.createRelease'
