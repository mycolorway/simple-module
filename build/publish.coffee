gulp = require 'gulp'
ghPages = require 'gulp-gh-pages'
fs = require 'fs'
pkg = require '../package.json'
helper = require './helper.coffee'

gulp.task 'publish.version', ->
  bowerConfig = require '../bower.json'
  bowerConfig.version = pkg.version
  fs.writeFileSync './bower.json', JSON.stringify(bowerConfig, null, 2)

gulp.task 'publish.docs', ['compile'], (cb) ->
  gulp.src '_docs/**/*'
    .pipe ghPages
      cacheDir: '.docs_publish_cache'
  helper.removeDir '.publish'
  cb()

gulp.task 'publish.createRelease', ['publish.docs'], ->

gulp.task 'publish', [
  'publish.version',
  'compile',
  'test',
  'publish.docs',
  'publish.createRelease'
]
