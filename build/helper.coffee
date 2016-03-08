fs = require 'fs'
request = require 'request'
prompt = require 'prompt'

removeDir = (dirPath) ->
  return unless fs.existsSync dirPath

  fs.readdirSync(dirPath).forEach (file, index) ->
    filePath = "#{dirPath}/#{file}"
    if fs.lstatSync(filePath).isDirectory()
      removeDir filePath
    else
      fs.unlinkSync filePath

  fs.rmdirSync dirPath


getReleaseVersion = ->
  changelogs = fs.readFileSync('CHANGELOG.md').toString()
  result = changelogs.match /## V(\d+\.\d+\.\d+)/

  if result and result.length > 1
    result[1]
  else
    null

getReleaseContent = (version) ->
  changelogs = fs.readFileSync('CHANGELOG.md').toString()
  re = new RegExp "## V#{version.replace('.', '\\.')}.+\\n\\n((?:\\* .*\\n)+)"
  result = changelogs.match re

  if result and result.length > 1
    result[1]
  else
    null

createRelease = (token, twoFactorCode) ->
  pkg = require '../package.json'
  content = getReleaseContent pkg.version
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
      'User-Agent': 'Mycolorway Release',
      'X-GitHub-OTP': twoFactorCode || undefined
  , (err, response, body) ->
    if err
      throw new Error 'Publish: Error occured while creating github release.'
    else if response.statusCode == 401
      otpHeader = response.headers['X-GitHub-OTP']
      if otpHeader and otpHeader.indexOf('required') > -1
        prompt.start()
        prompt.get [{
          name: 'two-factor authentication code',
          required: true,
          hidden: true
        }], (error, result) ->
          createRelease token, result['two-factor authentication code']
      else
        throw new Error "Publish: #{response.statusCode} #{JSON.stringify response.body}"
    else if response.statusCode.toString().search(/2\d\d/) > -1
      console.log "#{pkg.name} v#{pkg.version} released on github"
    else
      throw new Error "Publish: #{response.statusCode} #{JSON.stringify response.body}"

module.exports =
  removeDir: removeDir
  getReleaseVersion: getReleaseVersion
  getReleaseContent: getReleaseContent
  createRelease: createRelease
