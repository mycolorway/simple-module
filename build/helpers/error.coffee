gutil = require 'gulp-util'

module.exports = (error, stream) ->
  if stream
    stream.emit 'error', new gutil.PluginError 'gulp-build', error,
      stack: error.stack
      showStack: !!error.stack
  else
    gutil.log gutils.colors.red("gulp-build error: #{error.message || error}")
