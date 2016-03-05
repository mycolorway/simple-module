gulp = require 'gulp'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
through = require 'through2'
path = require 'path'
fs = require 'fs'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
pkg = require '../package.json'
navItems = require '../docs/data/nav.json'

gulp.task 'docs', ['docs.clean', 'docs.jade', 'docs.coffee', 'docs.sass']

gulp.task 'docs.clean', (cb) ->
  removeDir '_docs'
  cb()

gulp.task 'docs.jade', ['docs.clean'], ->

  gulp.src(['docs/**/*.jade', '!docs/layouts/**/*.jade'])
    .pipe through.obj (file, encoding, done) ->
      file.data =
        pkg: pkg
        navItems: navItems
        filename: path.basename(file.path, '.jade')
      @push file
      done()
    .pipe jade()
    .pipe through.obj (file, encoding, done) ->
      file.path = path.join file.base, "#{file.data.filename}.html"
      @push file
      done()
    .pipe gulp.dest '_docs'

gulp.task 'docs.coffee', ['docs.clean'], ->
  gulp.src 'docs/**/*.coffee'
    .pipe coffee().on('error', gutil.log)
    .pipe gulp.dest('_docs/')

gulp.task 'docs.sass', ['docs.clean'], ->
  gulp.src 'docs/**/*.scss'
    .pipe sass().on('error', sass.logError)
    .pipe gulp.dest('_docs/')


removeDir = (dirPath) ->
  return unless fs.existsSync dirPath

  fs.readdirSync(dirPath).forEach (file, index) ->
    filePath = "#{dirPath}/#{file}"
    if fs.lstatSync(filePath).isDirectory()
      removeDir filePath
    else
      fs.unlinkSync filePath

  fs.rmdirSync dirPath
