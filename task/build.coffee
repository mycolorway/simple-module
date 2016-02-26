gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'

gulp.task 'build.src', ->
  gulp.src 'src/**/*.coffee'
    .pipe coffee(bare: true).on('error', gutil.log)
    .pipe gulp.dest('dist/')

gulp.task 'build', ['build.src']
