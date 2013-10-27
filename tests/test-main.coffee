###
another one monkey patch to prevent "no timestamp" error
https://github.com/karma-runner/karma-requirejs/issues/6#issuecomment-23037725
###
((global) ->
  fileWithoutLeadingSlash = undefined

  # array where all spec files will be included
  global.tests = []
  for file of global.__karma__.files
    if global.__karma__.files.hasOwnProperty(file)

      # get rid of leading slash in file path - prevents "no timestamp" error
      fileWithoutLeadingSlash = file.replace(/^\//, "")
      global.__karma__.files[fileWithoutLeadingSlash] = global.__karma__.files[file]
      delete global.__karma__.files[file]


      # we get all the test files automatically and store to window.tests array
      global.tests.push fileWithoutLeadingSlash  if /spec\.js$/.test(fileWithoutLeadingSlash)
) this

# let Angular know that we're bootstrapping manually
# https://github.com/angular/angular.js/commit/603fe0d19608ffe1915d8bc23bf412912e7ee1ac
(window or {}).name = 'NG_DEFER_BOOTSTRAP!'


REQUIREJS_CONFIG = 
  paths:
    'jquery'          : './libs/jquery/jquery'
    'async'           : './libs/requirejs-plugins/src/async'
    'domReady'        : './libs/requirejs-domready/domReady'
    'angular'         : './libs/angular/angular'
    'angular-resource': './libs/angular-resource/angular-resource'    
    'lodash'          : './libs/lodash/dist/lodash'
    'oauth'           : './vendor/oauthio/oauth'
    'oboe'            : './libs/oboe/dist/oboe-browser'
    # named modules for test dependencies
    'angular-mocks'   : './libs/angular-mocks/angular-mocks'
    'chai'            : './libs/chai/chai'
  shim:
    'oauth':
      exports: 'OAuth'

    'lodash':
      exports: '_'

    'oboe':
      exports: 'oboe'

    'angular':
      exports: 'angular'

    'angular-mocks':
      deps: ['angular']

    'angular-resource':
      deps: ['angular']

require.config
  baseUrl: 'base/.tmp/js/'
  paths: REQUIREJS_CONFIG.paths
  shim: REQUIREJS_CONFIG.shim
  # array with all spec files
  deps: window.tests
  callback: window.__karma__.start