gulp = require 'gulp'
bump = require 'gulp-bump'
pkg = require '../package.json'

gulp.task 'publish.version', ->
  gulp.src ['bower.json']
    .pipe bump({
      version: pkg.version
    })
    .pipe gulp.dest('/')

gulp.task 'publish.docs', ['compile'], (cb) ->
  cb()

gulp.task 'publish.createRelease', ['publish.docs'], ->

gulp.task 'publish', [
  'publish.version',
  'compile',
  'test',
  'publish.docs',
  'publish.createRelease'
]
