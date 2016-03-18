through = require 'through2'
path = require 'path'
lint = require 'sass-lint'

module.exports = (opts) ->
  through.obj (file, encoding, done) ->
    config = lint.getConfig opts
    result = lint.lintText
      text: file.contents
      format: path.extname(file.path).replace('.', '')
      filename: file.relative
    , config
    lint.outputResults [result], config

    @push file
    done()
