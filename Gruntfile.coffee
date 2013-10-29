module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    requirejs:
      compile:
        options:
          mainConfigFile: '.tmp/js/main.js'
          wrap: true
          name: 'main'
          optimize: 'none'
          baseUrl: '.tmp/js'
          out: 'build/js/main-src.js'
          'disabled/exclude': ['main.js']
          'disabled/insertRequire': ['./bootstrap']

    copy:
      dist:
        files: [
          {
            expand: true
            cwd: 'source/partials/'
            src: ['**/*']
            dest: 'build/partials'
          }
          {
            expand: true
            cwd: 'source/'
            src: ['index.html']
            dest: 'build/'
          }
          {
            expand: true
            cwd: 'source/js/libs'
            src: ['**/*']
            dest: 'build/js/libs' # so resources of libs are preserved
          }
          {
            expand: true
            cwd: 'source/js/'
            src: ['**/*.js']
            dest: '.tmp/js/' # so can be processed by requirejs
          }
          {
            expand: true
            cwd: 'assets/'
            src: ['**/*']
            dest: 'build/assets/'
          }
        ]

      livereload:
        files: [
          {
            expand: true
            cwd: 'source/js/'
            src: ['**/*']
            dest: '.tmp/js/'
          }
          {
            expand: true
            cwd: 'assets/'
            src: ['**/*']
            dest: '.tmp/assets/'
          }
        ]

    uglify:
      main:
        options:
          sourceMappingURL: './source-map.js'
          sourceMap: 'build/js/source-map.js'
          mangle: false

        files:
          'build/js/main.js': ['build/js/main-src.js']

    coffee:
      options:
        bare: true
        sourceMap: false
        sourceRoot: ''

      compile:
        files: [
          expand: true
          cwd: 'source/coffee'
          src: '**/*.coffee'
          dest: '.tmp/js/' # so can be processed by requirejs
          ext: '.js'
        ]

    less:
      compile:
        options:
          paths: ["source/less"]
        files: [
          {
            expand: true
            cwd: 'source/less/'
            src: ['**/*.less']
            dest: 'assets/css/'
            ext: '.css'
          }
        ]

    karma:
      #ci: # runs tests one time in PhantomJS, good for continuous integration
      #  configFile: 'tests/karma-compiled.conf.js'
      unit: # start testing server that listens for code updates
        configFile: 'tests/karma.conf.coffee'
        singleRun: true
        browsers: ['PhantomJS']

    coveralls:
      options:
        coverage_dir: 'coverage'

    connect:
      options:
        port: 9000

        # Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost'
        livereload: 35729

      livereload:
        options:
          open: true
          base: [
            '.tmp'
            'source'
          ]

      test:
        options:
          port: 9001
          base: [
            '.tmp'
            'tests'
            'source'
          ]

      dist:
        options:
          base: 'build'

    watch:
      coffee:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: ['source/coffee/**/*.coffee']
        tasks: ['coffee:compile']

      less:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: ['source/less/**/*.less']
        tasks: [
          'less:compile'
          'copy:livereload'
        ]

      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'

        files: [
          'source/**/*.html'
          'source/js/**/*.js'
          'source/images/**/*.{png,jpg,jpeg,gif,webp,svg}'
        ]


  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-karma-coveralls'


  grunt.registerTask 'live', [
    'less:compile'
    'coffee:compile'
    'copy:livereload'
  ]
  grunt.registerTask 'build', [
    'less:compile'
    'coffee:compile'
    'copy:dist'
    'requirejs:compile'
    'uglify'
  ]
  grunt.registerTask 'server', [
    'live'
    'connect:livereload'
    'watch'
  ]
  grunt.registerTask 'test', [
    'live'
    'karma:unit'
  ]
  
  grunt.registerTask 'ci', [
    'build'
    'test'
    'coveralls'
  ]

  grunt.registerTask 'default', ['build']