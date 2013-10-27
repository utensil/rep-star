# Karma configuration
# Generated on Sun Oct 27 2013 09:59:18 GMT+0800 (中国标准时间)
module.exports = (config) ->
  config.set

    # base path, that will be used to resolve files and exclude
    basePath: ".."

    # frameworks to use
    frameworks: [
      "jasmine"
      "requirejs"
    ]
    preprocessors:
      "tests/**/*.coffee": "coffee"
      ".tmp/js/*.js": "coverage"
      ".tmp/js/controllers/*.js": "coverage"
      ".tmp/js/directives/*.js": "coverage"
      ".tmp/js/filters/*.js": "coverage"
      ".tmp/js/services/*.js": "coverage"

    # list of files / patterns to load in the browser
    files: [
      "tests/test-main.coffee"
      {
        pattern: ".tmp/js/**/*.js"
        included: false
      }
      {
        pattern: "tests/specs/**/*.js"
        included: false
      }
      {
        pattern: "tests/specs/**/*.coffee"
        included: false
      }
    ]

    # list of files to exclude
    exclude: [
      '.tmp/js/main.js'
    ]

    # test results reporter to use
    # possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['progress', 'coverage']

    # optionally, configure the reporter
    coverageReporter: 
      type: 'html',
      dir: 'coverage/'

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ["PhantomJS"]

    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: true
