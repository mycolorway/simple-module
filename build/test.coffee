gulp = require 'gulp'
jasmine = require 'gulp-jasmine'

gulp.task 'test', ['compile.coffee'], ->
  gulp.src 'test/**/*.coffee'
    .pipe jasmine(verbose: true, includeStackTrace: true)
