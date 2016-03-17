require './build/compile.coffee'
require './build/test.coffee'
require './build/docs.coffee'
require './build/publish.coffee'
gulp = require 'gulp'
coffeelint = require 'gulp-coffeelint'
runSequence = require 'run-sequence'

gulp.task 'build.lint', ->
  gulp.src 'build/**/*.coffee'
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'default', ->
  runSequence 'build.lint', 'compile', 'test', 'docs', ->
    gulp.watch 'build/**/*.coffee', ['build.lint']

    gulp.watch 'src/**/*.coffee', ['compile.lint', 'compile.coffee', 'test']
    gulp.watch 'src/**/*.scss', ['compile.sass']
    gulp.watch 'test/**/*.coffee', ['test.lint', 'test']

    # watch docs files
    gulp.watch ['docs/**/*.jade', 'docs/data/**/*.json', 'README.md'], ['docs.jade']
    gulp.watch 'docs/**/*.jade', ['docs.jade']
    gulp.watch 'docs/**/*.coffee', ['docs.lint', 'docs.coffee']
    gulp.watch 'docs/**/*.scss', ['docs.sass']
