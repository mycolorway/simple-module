gulp = require 'gulp'
runSequence = require 'run-sequence'
path = require 'path'
helper = require './helper.coffee'


gulp.task 'docs.clean', ->
  helper.removeDir '_docs'

gulp.task 'docs.jade', ->
  gulp.src(['docs/**/*.jade', '!docs/layouts/**/*.jade'])
    .pipe helper.data (file) ->
      pkg: require '../package.json'
      navItems: require '../docs/data/nav.json'
      filename: path.basename(file.path, '.jade')
    .pipe helper.jade()
    .pipe helper.rename
      dirname: ''
      extname: '.html'
    .pipe gulp.dest '_docs'

gulp.task 'docs.coffee', ->
  gulp.src 'docs/**/*.coffee'
    .pipe helper.coffee()
    .pipe gulp.dest('_docs/')

gulp.task 'docs.sass', ->
  gulp.src 'docs/**/*.scss'
    .pipe helper.sass()
    .pipe gulp.dest('_docs/')

gulp.task 'docs', ->
  runSequence 'docs.clean', [
    'docs.jade',
    'docs.coffee',
    'docs.sass'
  ]
