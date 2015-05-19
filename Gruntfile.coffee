module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      src:
        options:
          bare: true
        files:
          'lib/module.js': 'src/module.coffee'
      spec:
        files:
          'spec/module-spec.js': 'spec/module-spec.coffee'

    umd:
      all:
        src: 'lib/module.js'
        amdModuleId: 'simple-module'
        objectToExport: 'Module'
        globalAlias: 'SimpleModule'
        deps:
          'default': ['$']
          amd: ['jquery']
          cjs: ['jquery']
          global:
            items: ['jQuery']
            prefix: ''

    watch:
      spec:
        files: ['spec/**/*.coffee']
        tasks: ['coffee:spec']
      src:
        files: ['src/**/*.coffee']
        tasks: ['coffee:src', 'umd']
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
            'vendor/bower/jquery/dist/jquery.min.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'default', ['coffee', 'umd', 'jasmine:test:build', 'watch']
