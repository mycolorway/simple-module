gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
header = require 'gulp-header'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
pkg = require '../package.json'

gulp.task 'compile.coffee', (cb) ->
  gulp.src 'src/**/*.coffee'
    .pipe coffee(bare: true).on('error', gutil.log)
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
    .pipe rename(suffix: '.min')
    .pipe gulp.dest('dist/')

gulp.task 'compile', ['compile.coffee', 'compile.uglify'], (cb) ->
  cb()
