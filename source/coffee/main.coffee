# let Angular know that we're bootstrapping manually
# https://github.com/angular/angular.js/commit/603fe0d19608ffe1915d8bc23bf412912e7ee1ac
(window or {}).name = 'NG_DEFER_BOOTSTRAP!'

###
configure RequireJS
prefer named modules to long paths, especially for version mgt
or 3rd party libraries
###
require.config
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

require ['./bootstrap'], ->
  #nothing to do here...see bootstrap.js