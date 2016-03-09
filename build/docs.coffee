gulp = require 'gulp'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
runSequence = require 'run-sequence'
path = require 'path'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
helper = require './helper.coffee'

gulp.task 'docs.clean', ->
  helper.removeDir '_docs'

gulp.task 'docs.jade', ->
  gulp.src(['docs/**/*.jade', '!docs/layouts/**/*.jade'])
    .pipe helper.addData (file) ->
      pkg: require '../package.json'
      navItems: require '../docs/data/nav.json'
      filename: path.basename(file.path, '.jade')
    .pipe jade()
    .pipe helper.rename
      dirname: ''
      extname: '.html'
    .pipe gulp.dest '_docs'

gulp.task 'docs.coffee', ->
  gulp.src 'docs/**/*.coffee'
    .pipe coffee().on('error', gutil.log)
    .pipe gulp.dest('_docs/')

gulp.task 'docs.sass', ->
  gulp.src 'docs/**/*.scss'
    .pipe sass().on('error', sass.logError)
    .pipe gulp.dest('_docs/')

gulp.task 'docs', ->
  runSequence 'docs.clean', [
    'docs.jade',
    'docs.coffee',
    'docs.sass'
  ]
