gulp = require 'gulp'
runSequence = require 'run-sequence'
path = require 'path'
coffeelint = require './helpers/coffeelint.coffee'
coffee = require './helpers/coffee.coffee'
sasslint = require './helpers/sasslint.coffee'
sass = require './helpers/sass.coffee'
autoprefixer = require './helpers/autoprefixer.coffee'
removeDir = require './helpers/remove-dir.coffee'
data = require './helpers/data.coffee'
jade = require './helpers/jade.coffee'
rename = require './helpers/rename.coffee'

gulp.task 'docs.clean', ->
  removeDir '_docs'

gulp.task 'docs.jade', ->
  gulp.src(['docs/**/*.jade', '!docs/layouts/**/*.jade'])
    .pipe data (file) ->
      pkg: require '../package.json'
      navItems: require '../docs/data/nav.json'
      filename: path.basename(file.path, '.jade')
    .pipe jade()
    .pipe rename
      dirname: ''
      extname: '.html'
    .pipe gulp.dest '_docs'

gulp.task 'docs.coffee', ->
  gulp.src 'docs/**/*.coffee'
    .pipe coffeelint()
    .pipe coffee()
    .pipe gulp.dest('_docs/')

gulp.task 'docs.sass', ->
  gulp.src 'docs/**/*.scss'
    .pipe sasslint()
    .pipe sass()
    .pipe autoprefixer
      browsers: ['last 2 versions']
    .pipe gulp.dest('_docs/')

gulp.task 'docs', (done) ->
  runSequence 'docs.clean', [
    'docs.jade',
    'docs.coffee',
    'docs.sass',
  ], done
