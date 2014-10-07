module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      module:
        files:
          'lib/module.js': 'src/module.coffee'
          'spec/module-spec.js': 'spec/module-spec.coffee'
    watch:
      scripts:
        files: ['src/**/*.coffee', 'spec/**/*.coffee']
        tasks: ['coffee']
      jasmine:
        files: ['lib/**/*.js', 'specs/**/*.js'],
        tasks: 'jasmine:test:build'
    jasmine:
      test:
        src: 'lib/**/*.js'
        options:
          outfile: 'spec/index.html'
          specs: 'spec/module-spec.js'
          vendor: [
            'vendor/bower/jquery/dist/jquery.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'

  grunt.registerTask 'default', ['coffee', 'jasmine:test:build', 'watch']


