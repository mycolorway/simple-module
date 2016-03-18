gulp = require 'gulp'
gutil = require 'gulp-util'
ghPages = require 'gulp-gh-pages'
runSequence = require 'run-sequence'
fs = require 'fs'
request = require 'request'
pkg = require '../package.json'
removeDir = require './helpers/remove-dir.coffee'
handleError = require './helpers/error.coffee'

gulp.task 'publish.docs', ['docs.jade'], ->
  gulp.src '_docs/**/*'
    .pipe ghPages().on 'end', -> removeDir '.publish'

gulp.task 'publish.createRelease', ->
  try
    token = require '../.token.json'
  catch e
    throw new Error 'Publish: Need github access token for creating release.'
    return

  createRelease token.github

gulp.task 'publish', ->
  runSequence 'compile', 'test', 'docs', 'publish.docs', 'publish.createRelease'


createRelease = (token) ->
  pkg = require '../package.json'
  content = changelogs.latestContent
  unless content
    throw new Error('Publish: Invalid release content in CHANGELOG.md')
    return

  request
    uri: "https://api.github.com/repos/#{pkg.githubOwner}/#{pkg.name}/releases"
    method: 'POST'
    json: true
    body:
      tag_name: "v#{pkg.version}",
      name: "v#{pkg.version}",
      body: content,
      draft: false,
      prerelease: false
    headers:
      Authorization: "token #{token}",
      'User-Agent': 'Mycolorway Release'
  , (error, response, body) ->
    if error
      handleError error
    else if response.statusCode.toString().search(/2\d\d/) > -1
      message = "#{pkg.name} v#{pkg.version} released on github!"
      gutil.log gutil.colors.green successMsg
    else
      message = "#{response.statusCode} #{JSON.stringify response.body}"
      handleError gutil.colors.red message
