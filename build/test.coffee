gulp = require 'gulp'
coffeelint = require './helpers/coffeelint'
mocha = require './helpers/mocha'

gulp.task 'test', ->
  gulp.src 'test/**/*.coffee'
    .pipe coffeelint()
    .pipe mocha()
