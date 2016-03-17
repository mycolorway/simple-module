gulp = require 'gulp'
coveralls = require 'coveralls'
runSequence = require 'run-sequence'
through = require 'through2'
helper = require './helper.coffee'

gulp.task 'test.run', ->
  gulp.src 'test/**/*.coffee'
    .pipe helper.mocha()
    # .pipe istanbul.writeReports()

gulp.task 'test.coveralls', ->
  return unless process.env.CI

  gulp.src 'coverage/lcov.info'
    .pipe through.obj (file, encoding, done) ->
      input = file.contents.toStirng()
      stream = @

      coveralls.getBaseOptions (error, options) ->
        if error
          helper.handleError error, stream
          return

        options.filepath = '.'
        coveralls.convertLcovToCoveralls input, options, (error, postData) ->
          if error
            helper.handleError error, stream
            return

          coveralls.sendToCoveralls postData, (err, response, body) ->
            if error
              helper.handleError error, stream

            if response.statusCode >= 400
              helper.handleError "Bad response: #{response.statusCode} #{body}", stream

            done()


gulp.task 'test', ->
  runSequence 'test.run', 'test.coveralls'
