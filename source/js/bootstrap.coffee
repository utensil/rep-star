###
bootstraps angular onto the window.document node
NOTE: the ng-app attribute should not be on the index.html when using ng.bootstrap
###
define [
  "require"
  "jquery"
  "angular"
  "app"
  "routes"
  "impl"
], (require, $, ng) ->
  "use strict"
  
  #place operations that need to initialize prior to app start here
  #     * using the `run` function on the top-level module
  #     
  require [
    "domReady!"
    "oauth"
  ], (document, OAuth) ->
    OAuth.initialize "h-dZ4aahHsuqamiK-VjvIvnthhI"
    
    # everything is loaded...go! 
    ng.bootstrap document, ["app"]
    ng.resumeBootstrap()


