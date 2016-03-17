gulp = require 'gulp'
fs = require 'fs'
runSequence = require 'run-sequence'
coffeelint = require 'gulp-coffeelint'
helper = require './helper.coffee'

gulp.task 'compile.lint', ->
  gulp.src 'src/**/*.coffee'
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'compile.version', ->
  newVersion = getReleaseVersion()
  unless newVersion
    throw new Error('Publish: Invalid version in CHANGELOG.md')
    return

  pkg = require '../package.json'
  pkg.version = newVersion
  fs.writeFileSync './package.json', JSON.stringify(pkg, null, 2)

  bowerConfig = require '../bower.json'
  bowerConfig.version = newVersion
  fs.writeFileSync './bower.json', JSON.stringify(bowerConfig, null, 2)

gulp.task 'compile.coffee', ->
  gulp.src 'src/**/*.coffee'
    .pipe helper.coffee()
    .pipe helper.fileHeader()
    .pipe gulp.dest('dist/')

gulp.task 'compile.sass', ->
  gulp.src 'src/**/*.scss'
    .pipe helper.sass()
    .pipe helper.fileHeader()
    .pipe gulp.dest('dist/')

gulp.task 'compile.uglify', ->
  gulp.src ['dist/**/*.js', '!dist/**/*.min.js']
    .pipe helper.uglify()
    .pipe helper.fileHeader('simple')
    .pipe helper.rename
      suffix: '.min'
    .pipe gulp.dest('dist/')

gulp.task 'compile', (done) ->
  runSequence(
    'compile.lint',
    'compile.version',
    'compile.coffee',
    'compile.uglify',
    done
  )


getReleaseVersion = ->
  changelogs = fs.readFileSync('CHANGELOG.md').toString()
  result = changelogs.match /## V(\d+\.\d+\.\d+)/

  if result and result.length > 1
    result[1]
  else
    null
