// let Angular know that we're bootstrapping manually
// https://github.com/angular/angular.js/commit/603fe0d19608ffe1915d8bc23bf412912e7ee1ac
(window || {}).name = "NG_DEFER_BOOTSTRAP!";

/**
 * configure RequireJS
 * prefer named modules to long paths, especially for version mgt
 * or 3rd party libraries
 */
require.config({
  "paths": {
      "async"             : "./libs/requirejs-plugins/src/async",
      "domReady"          : "./libs/requirejs-domready/domReady",
      "angular"           : "./libs/angular/angular",
      "angular-resource"  : "./libs/angular-resource/angular-resource",
      "lodash"            : "./libs/lodash/dist/lodash",
      "oauth"             : "./libs/oauthio/app/js/oauth",
      "oboe"              : "./libs/oboe/dist/oboe-browser"
  },

  "shim": {
      "oauth": {
          "exports": "OAuth"
      },
      "lodash": {
          "exports": "_"
      },
      "oboe": {
          "exports": "oboe"
      },
      "angular": {
          "exports": "angular"
      },
      "angular-mocks": {
          "deps": ["angular"]
      },
      "angular-resource": {
          "deps": ["angular"]
      }
  }
});

require(['./bootstrap'], function () {
    //nothing to do here...see bootstrap.js
});
