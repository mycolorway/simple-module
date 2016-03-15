gulp = require 'gulp'
path = require 'path'
Jasmine = require 'jasmine'
helper = require './helper.coffee'

gulp.task 'test', ->
  specFile = 'test/simple-module.coffee'
  fileId = require.resolve path.resolve(specFile)
  helper.deleteRequireCache fileId

  jasmine = new Jasmine()
  jasmine.onComplete (passed) ->
    # do nothing
  jasmine.execute [specFile]
