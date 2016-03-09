gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
uglify = require 'gulp-uglify'
runSequence = require 'run-sequence'
helper = require './helper.coffee'

gulp.task 'compile.coffee', ->
  gulp.src 'src/**/*.coffee'
    .pipe coffee().on('error', gutil.log)
    .pipe helper.fileHeader()
    .pipe gulp.dest('dist/')

gulp.task 'compile.sass', ->
  gulp.src 'src/**/*.scss'
    .pipe sass().on('error', sass.logError)
    .pipe helper.fileHeader()
    .pipe gulp.dest('dist/')

gulp.task 'compile.uglify', ->
  gulp.src ['dist/**/*.js', '!dist/**/*.min.js']
    .pipe uglify()
    .pipe helper.fileHeader('simple')
    .pipe helper.rename
      suffix: '.min'
    .pipe gulp.dest('dist/')

gulp.task 'compile', ->
  runSequence 'compile.coffee', 'compile.uglify'
