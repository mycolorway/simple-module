gulp = require 'gulp'
coveralls = require 'coveralls'
runSequence = require 'run-sequence'
through = require 'through2'
coffeelint = require './helpers/coffeelint.coffee'
mocha = require './helpers/mocha.coffee'

gulp.task 'test.run', ->
  gulp.src 'test/**/*.coffee'
    .pipe coffeelint()
    .pipe mocha()

gulp.task 'test.coveralls', ->
  return unless process.env.CI

  gulp.src 'coverage/lcov.info'


gulp.task 'test', (done) ->
  runSequence 'test.run', 'test.coveralls', done
