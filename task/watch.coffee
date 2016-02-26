gulp = require 'gulp'

gulp.task 'watch.src', ->
  gulp.watch 'src/**/*.coffee', ['build.src']

gulp.task 'watch.test', ->
  gulp.watch 'test/**/*.coffee', ['test']

gulp.task 'watch', ['watch.src', 'watch.test']
