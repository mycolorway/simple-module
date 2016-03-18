through = require 'through2'
coffeelint = require 'coffeelint'
Reporter = require 'coffeelint/lib/reporters/default'

module.exports = (opts) ->
  through.obj (file, encoding, done) ->
    errorReport = coffeelint.getErrorReport()
    errorReport.lint file.relative, file.contents.toString(), opts
    
    summary = errorReport.getSummary()
    if summary.errorCount > 0 || summary.warningCount > 0
      reporter = new Reporter errorReport
      reporter.publish()

    @push file
    done()
