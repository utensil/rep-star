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
    'jquery'            : './libs/jquery/jquery'
    'async'             : './libs/requirejs-plugins/src/async'
    'domReady'          : './libs/requirejs-domready/domReady'
    'angular'           : './libs/angular/angular'
    'angular-resource'  : './libs/angular-resource/angular-resource'
    'angular-sanitize'  : './libs/angular-sanitize/angular-sanitize'
    'angular-route'     : './libs/angular-route/angular-route'
    'ngstorage'         : './libs/ngstorage/ngStorage' 
    'lodash'            : './libs/lodash/dist/lodash'
    'oauth'             : './vendor/oauthio/oauth'
    'oboe'              : './libs/oboe/dist/oboe-browser'
    'jquery.mousewheel' : './libs/perfect-scrollbar/src/jquery.mousewheel'
    'perfect-scrollbar' : './libs/perfect-scrollbar/src/perfect-scrollbar'
    'jquery.bpopup'     : './libs/bpopup/jquery.bpopup'
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

    'jquery.mousewheel':
      deps: ['jquery']

    'perfect-scrollbar':
      deps: ['jquery', 'jquery.mousewheel']

    'jquery.bpopup':
      deps: ['jquery']

    'angular':
      exports: 'angular'

    'angular-mocks':
      deps: ['angular']

    'angular-resource':
      deps: ['angular']

    'ngstorage':
      deps: ['angular']

    'angular-route':
      deps: ['angular']
      
    'angular-sanitize':
      deps: ['angular']


require ['./bootstrap'], ->
  #nothing to do here...see bootstrap.js