gutil = require 'gulp-util'
through = require 'through2'
autoprefixer = require 'autoprefixer'
postcss = require 'postcss'
handleError = require './error.coffee'

module.exports = (opts) ->
  through.obj (file, encoding, done) ->
    postcss(autoprefixer(opts)).process file.contents.toString(),
      map: false
      from: file.path
      to: file.path
    .then (res) =>
      file.contents = new Buffer res.css

      warnings = res.warnings()
      if warnings.length > 0
        gutil.log 'autoprefixer:', '\n  ' + warnings.join('\n  ')

      @push file
      done()
    .catch (err) ->
      cssError = err.name == 'CssSyntaxError'
      err.message += err.showSourceCode() if cssError

      handleError err
      @push file
      done()
