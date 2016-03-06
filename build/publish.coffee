gulp = require 'gulp'
fs = require 'fs'
pkg = require '../package.json'

gulp.task 'publish.version', ->
  bowerConfig = require '../bower.json'
  bowerConfig.version = pkg.version
  fs.writeFile '../bower.json', JSON.stringify(bowerConfig, null, 2)

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
