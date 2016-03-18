through = require 'through2'
handleError = require './error.coffee'
coveralls = require 'coveralls'

module.exports = ->
  through.obj (file, encoding, done) ->
  input = file.contents.toString()
  stream = @

  coveralls.getBaseOptions (error, options) ->
    if error
      handleError error, stream
      return

    options.filepath = '.'
    coveralls.convertLcovToCoveralls input, options, (error, postData) ->
      if error
        handleError error, stream
        return

      coveralls.sendToCoveralls postData, (err, response, body) ->
        if error
          handleError error, stream

        if response.statusCode >= 400
          handleError(
            "Bad response: #{response.statusCode} #{body}",
            stream
          )

        done()
