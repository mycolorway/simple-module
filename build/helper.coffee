fs = require 'fs'
path = require 'path'
gutil = require 'gulp-util'
through = require 'through2'
_ = require 'lodash'
pkg = require '../package.json'

removeDir = (dirPath) ->
  return unless fs.existsSync dirPath

  fs.readdirSync(dirPath).forEach (file, index) ->
    filePath = "#{dirPath}/#{file}"
    if fs.lstatSync(filePath).isDirectory()
      removeDir filePath
    else
      fs.unlinkSync filePath

  fs.rmdirSync dirPath

headerTemplate =
  full: """
    /**
     * <%= name %> v<%= version %>
     * <%= homepage %>
     *
     * Copyright Mycolorway Design
     * Released under the MIT license
     * <%= homepage %>/license.html
     *
     * Date: <%= date %>
     */\n\n
  """
  simple: "/* <%= name %> v<%= version %> | (c) Mycolorway Design | MIT License */\n"

gulpFileHeader = (type = 'full') ->
  now = new Date()
  year = now.getFullYear()
  month = _.padStart(now.getMonth() + 1, 2, '0')
  date = now.getDate()
  header = _.template(headerTemplate[type])
    name: pkg.name
    version: pkg.version
    homepage: pkg.homepage
    date: "#{year}-#{month}-#{date}"

  through.obj (file, encoding, done) ->
    headerBuffer = new Buffer header
    file.contents = Buffer.concat [headerBuffer, file.contents]
    @push file
    done()

gulpRename = (opts) ->
  opts = _.extend
    prefix: ''
    suffix: ''
    dirname: null
    basename: null
    extname: null
  , opts

  through.obj (file, encoding, done) ->
    dirname = path.dirname file.relative
    extname = path.extname file.relative
    basename = path.basename file.relative, extname
    newDirName = if _.isNull(opts.dirname) then dirname else opts.dirname
    newExtName = if _.isNull(opts.extname) then extname else opts.extname
    newBaseName = if _.isNull(opts.basename) then basename else opts.basename

    filename = "#{opts.prefix}#{newBaseName}#{opts.suffix}#{newExtName}"
    file.path = path.join file.base, newDirName, filename
    @push file
    done()

gulpData = (data) ->
  through.obj (file, encoding, done) ->
    file.data = if _.isFunction(data) then data(file) else data
    @push file
    done()

gulpJade = (opts) ->
  through.obj (file, encoding, done) ->
    opts = _.extend {filename: file.path}, opts
    file.path = gutil.replaceExtension file.path, '.html'
    try
      jade = require 'jade'
      compile = jade.compile file.contents.toString(), opts
      result = compile _.extend {}, opts.locals, file.data
      file.contents = new Buffer result
    catch e
      handleError e, @
    @push file
    done()

gulpCoffee = (opts) ->
  through.obj (file, encoding, done) ->
    str = file.contents.toString()

    try
      coffee = require 'coffee-script'
      result = coffee.compile str, opts
    catch e
      handleError e, @

    file.contents = new Buffer result
    file.path = gutil.replaceExtension file.path, '.js'
    @push file
    done()

gulpSass = (opts) ->
  through.obj (file, encoding, done) ->
    opts = _.extend
      data: file.contents.toString()
      includePath: [path.dirname(file.path)]
    , opts

    try
      sass = require 'node-sass'
      result = sass.renderSync opts
    catch e
      handleError e, @

    file.contents = new Buffer result.css
    file.path = gutil.replaceExtension file.path, '.css'
    @push file
    done()

gulpUglify = (opts) ->
  through.obj (file, encoding, done) ->
    opts = _.extend {fromString: true}, opts

    try
      uglify = require 'uglify-js'
      result = uglify.minify file.contents.toString(), opts
    catch e
      handleError e, @

    file.contents = new Buffer result.code
    @push file
    done()

requireCache =
  marked: {}
  mark: ->
    Object.keys(require.cache).forEach (key) ->
      requireCache.marked[key] = true
  clear: ->
    Object.keys(require.cache).forEach (key) ->
      if !requireCache.marked[key] && !/\.node$/.test(key)
        delete require.cache[key]

handleError = (error, stream) ->
  if stream
    stream.emit 'error', new gutil.PluginError 'gulp-build', error,
      stack: error.stack
      showStack: !!error.stack
  else
    gutil.log gutils.colors.red("gulp-build error: #{error.message || error}")

gulpMocha = (opts = {}) ->
  require 'coffee-script/register'

  coverageVar = "$$cov_#{Date.now()}$$"
  require('coffee-coverage').register
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

  Mocha = require 'mocha'
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
        istanbul = require 'istanbul'
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

module.exports =
  removeDir: removeDir
  fileHeader: gulpFileHeader
  rename: gulpRename
  data: gulpData
  jade: gulpJade
  coffee: gulpCoffee
  sass: gulpSass
  uglify: gulpUglify
  requireCache: requireCache
  handleError: handleError
  mocha: gulpMocha
