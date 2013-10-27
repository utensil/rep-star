###
This is where you add new components to the application
you don't need to sweat the dependency order (that is what RequireJS is for)
but implementations' `define`s placed elsewhere void the warranty
###
define [
  "controllers/home-ctrl"
  "testcf"
  "lodash"
  "oauth"
  "oboe"
], (home_ctrl, test_cf, _, oauth, oboe) ->
  #console.log(home_ctrl);
  #console.log(test_cf);
  #console.log(_);
  #console.log(oauth);
  #console.log(oboe);
