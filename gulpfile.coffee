require './build/compile.coffee'
require './build/test.coffee'
require './build/docs.coffee'
require './build/publish.coffee'
gulp = require 'gulp'
runSequence = require 'run-sequence'

gulp.task 'default', ->
  runSequence 'compile', ['test', 'docs'], ->
    gulp.watch 'src/**/*.coffee', ['compile.coffee', 'test']
    gulp.watch 'src/**/*.scss', ['compile.sass']
    gulp.watch 'test/**/*.coffee', ['test']

    # watch docs files
    gulp.watch 'docs/**/*.jade', ['docs.jade']
    gulp.watch 'docs/**/*.coffee', ['docs.coffee']
    gulp.watch 'docs/**/*.scss', ['docs.sass']
