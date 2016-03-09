gulp = require 'gulp'
# coffee = require 'gulp-coffee'
jasmine = require 'gulp-jasmine-phantom'

gulp.task 'test', ->
  gulp.src 'test/**/*.coffee'
    .pipe jasmine(includeStackTrace: true)

  # Test code in browser:
  # gulp.src 'test/**/*.coffee'
  #   .pipe coffee()
  #   .pipe gulp.dest('test/')
  #   .pipe jasmine
  #     keepRunner: 'test/'
  #     integration: true
  #     vendor: [
  #       'node_modules/eventemitter2/lib/eventemitter2.js'
  #       'node_modules/lodash/lodash.js'
  #       'dist/simple-module.js'
  #     ]
