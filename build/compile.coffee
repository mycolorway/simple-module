gulp = require 'gulp'
fs = require 'fs'
runSequence = require 'run-sequence'
coffeelint = require './helpers/coffeelint.coffee'
coffee = require './helpers/coffee.coffee'
sasslint = require './helpers/sasslint.coffee'
sass = require './helpers/sass.coffee'
sass = require './helpers/autoprefixer.coffee'
header = require './helpers/header.coffee'
rename = require './helpers/rename.coffee'
uglify = require './helpers/uglify.coffee'
changelogs = require './helpers/changelogs.coffee'

gulp.task 'compile.version', ->
  newVersion = changelogs.lastestVersion
  unless newVersion
    throw new Error('Publish: Invalid version in CHANGELOG.md')
    return

  pkg = require '../package.json'
  pkg.version = newVersion
  fs.writeFileSync './package.json', JSON.stringify(pkg, null, 2)

  bowerConfig = require '../bower.json'
  bowerConfig.version = newVersion
  fs.writeFileSync './bower.json', JSON.stringify(bowerConfig, null, 2)

gulp.task 'compile.coffee', ->
  gulp.src 'src/**/*.coffee'
    .pipe coffeelint()
    .pipe coffee()
    .pipe header()
    .pipe gulp.dest('dist/')

gulp.task 'compile.sass', ->
  gulp.src 'src/**/*.scss'
    .pipe sasslint()
    .pipe sass()
    .pipe autoprefixer
      browsers: ['last 2 versions']
    .pipe header()
    .pipe gulp.dest('dist/')

gulp.task 'compile.uglify', ->
  gulp.src ['dist/**/*.js', '!dist/**/*.min.js']
    .pipe uglify()
    .pipe header('simple')
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest('dist/')

gulp.task 'compile', (done) ->
  runSequence(
    'compile.version',
    'compile.coffee',
    'compile.uglify',
    done
  )
