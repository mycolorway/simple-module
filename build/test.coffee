gulp = require 'gulp'
coffeelint = require './helpers/coffeelint'
coverage = require './helpers/coverage'
mochaPhantomjs = require './helpers/mocha-phantomjs'
rename = require './helpers/rename'
browserify = require './helpers/browserify'
umd = require './helpers/umd'

compileTest = ->
  gulp.src 'test/simple-module.coffee'
    .pipe coffeelint()
    .pipe browserify()
    .pipe rename
      suffix: '-test'
    .pipe gulp.dest('test/runner')
compileTest.displayName = 'compile-test'

compileSrc = (done) ->
  gulp.src 'src/simple-module.coffee'
    .pipe coffeelint()
    .pipe coverage()
    .pipe gulp.dest('test/runner')
    .on 'end', ->
      gulp.src 'test/runner/simple-module.js'
        .pipe browserify()
        .pipe umd()
        .pipe gulp.dest('test/runner')
        .on 'end', ->
          done()
compileSrc.displayName = 'compile-src'

test = gulp.parallel compileSrc, compileTest, (done) ->
  mochaPhantomjs 'test/runner/index.html', done

gulp.task 'test', test
module.exports = test
