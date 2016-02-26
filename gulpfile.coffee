require './task/build.coffee'
require './task/test.coffee'
require './task/watch.coffee'

require('gulp').task 'default', ['build', 'test', 'watch']
