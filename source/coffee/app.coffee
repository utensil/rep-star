###
loads sub modules and wraps them up into the main module
this should be used for top-level module definitions only
(in other words... you probably don't need to do stuff here)
###
define [
  "angular"
  "./config"
  "./controllers/index"
  "./directives/index"
  "./filters/index"
  "./services/index"
], (ng) ->
  "use strict"
  ng.module "app", [
    "app.constants"
    "app.services"
    "app.controllers"
    "app.filters"
    "app.directives"
  ]

