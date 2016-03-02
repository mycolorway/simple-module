gulp = require 'gulp'
jasmine = require 'gulp-jasmine-phantom'

gulp.task 'test', ['compile.coffee'], ->
  gulp.src 'test/**/*.coffee'
    .pipe jasmine()

  # Test code in browser:
  # gulp.src 'test/**/*.coffee'
  #   .pipe coffee()
  #   .pipe jasmine()
  #   .pipe gulp.dest('test/')
  #   .pipe jasmine
  #     integration: true
  #     vendor: [
  #       'node_modules/eventemitter2/lib/eventemitter2.js'
  #       'node_modules/lodash/lodash.js'
  #       'dist/simple-module.js'
  #     ]
