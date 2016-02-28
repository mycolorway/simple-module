require './build/compile.coffee'
require './build/test.coffee'
require './build/docs.coffee'
require './build/publish.coffee'
gulp = require 'gulp'

gulp.task 'default', ['compile', 'test'], ->
  gulp.watch 'src/**/*.coffee', ['compile.coffee', 'test']
  gulp.watch 'test/**/*.coffee', ['test']
