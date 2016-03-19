require 'coffee-script/register'
through = require 'through2'
coffeeCoverage = require 'coffee-coverage'
Mocha = require 'mocha'
istanbul = require 'istanbul'
_ = require 'lodash'
handleError = require './error'

requireCache =
  marked: {}
  mark: ->
    Object.keys(require.cache).forEach (key) =>
      @marked[key] = true
  clear: ->
    Object.keys(require.cache).forEach (key) =>
      if !@marked[key] && !/\.node$/.test(key)
        delete require.cache[key]

module.exports = (opts = {}) ->
  coverageVar = "$$cov_#{Date.now()}$$"
  coffeeCoverage.register
    instrumentor: 'istanbul'
    basePath: process.cwd()
    exclude: [
      '/test'
      '/node_modules'
      '/.git'
      'gulpfile.coffee'
      '/build'
      '/docs'
    ]
    coverageVar: coverageVar
    initAll: true

  mocha = new Mocha _.extend
    reporter: 'spec'
  , opts

  requireCache.mark()

  through.obj (file, encoding, done) ->
    mocha.addFile file.path
    @push file
    done()
  , (done) ->
    try
      mocha.run (errorCount) ->
        reporter = new istanbul.Reporter()
        collector = new istanbul.Collector()

        reporter.addAll ['lcov', 'text', 'text-summary']
        collector.add(global[coverageVar] || {})

        reporter.write collector, false, ->
          requireCache.clear()
          done()
    catch error
      requireCache.clear()
      handleError error, @
      done()
