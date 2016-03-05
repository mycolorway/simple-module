gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
header = require 'gulp-header'
uglify = require 'gulp-uglify'
through = require 'through2'
path = require 'path'
pkg = require '../package.json'

gulp.task 'compile.coffee', (cb) ->
  gulp.src 'src/**/*.coffee'
    .pipe coffee().on('error', gutil.log)
    .pipe header(pkg.banner.join('\n'), {
      pkg: pkg,
      date: (new Date()).toLocaleString('en-US')
    })
    .pipe gulp.dest('dist/')
  cb()

gulp.task 'compile.sass', (cb) ->
  gulp.src 'src/**/*.scss'
    .pipe sass().on('error', sass.logError)
    .pipe header(pkg.banner.join('\n'), {
      pkg: pkg,
      date: (new Date()).toLocaleString('en-US')
    })
    .pipe gulp.dest('dist/')
  cb()

gulp.task 'compile.uglify', ['compile.coffee'], ->
  gulp.src ['dist/**/*.js', '!dist/**/*.min.js']
    .pipe uglify()
    .pipe header("/* <%= pkg.name %> v<%= pkg.version %> | (c) Mycolorway Design | MIT License */\n", {
      pkg: pkg
    })
    .pipe through.obj (file, encoding, done) ->
      dirname = path.dirname file.relative
      extname = path.extname file.relative
      basename = path.basename file.relative, extname
      file.path = path.join file.base, dirname, "#{basename}.min#{extname}"
      @push file
      done()
    .pipe gulp.dest('dist/')

gulp.task 'compile', ['compile.coffee', 'compile.uglify'], (cb) ->
  cb()
