gulp = require 'gulp'
runSequence = require 'run-sequence'
helper = require './helper.coffee'

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

gulp.task 'compile', ->
  runSequence 'compile.coffee', 'compile.uglify'
