###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
  "./app"
  "./config"
], (app) ->
  "use strict"
  app.config ($routeProvider) ->
    $routeProvider.when "/",
      templateUrl: "partials/home.html"
      controller: "homeCtrl"

    $routeProvider.when "/rep-info",
      templateUrl: "partials/rep-info.html"
      controller: "repInfoCtrl"

    $routeProvider.otherwise redirectTo: "/"
    #$locationProvider.html5Mode(true);