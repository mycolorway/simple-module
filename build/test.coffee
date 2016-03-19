gulp = require 'gulp'
coffeelint = require './helpers/coffeelint.coffee'
mocha = require './helpers/mocha.coffee'

gulp.task 'test', ->
  gulp.src 'test/**/*.coffee'
    .pipe coffeelint()
    .pipe mocha()
