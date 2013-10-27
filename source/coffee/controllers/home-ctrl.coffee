define [
  "./index"
  "oauth"
  "oboe"
], (controllers, OAuth, oboe) ->
  "use strict"
  controllers.controller "homeCtrl", ($scope, $timeout) ->
    $scope.blah = "4"
    $scope.reps = []
    logStarredRep = (headers) ->
      (login) ->
        console.log login
        oboe.doGet(
          url: "https://api.github.com/users/" + login + "/starred"
          headers: headers
        ).node "$![*]": (reps) ->
          $timeout ->
            $scope.reps = reps           
    $scope.authGithub = ->
      OAuth.popup "github", (error, result) ->
        console.log error, result
        unless error
          headers = Authorization: "token " + result.access_token
          oboe.doGet(
            url: "https://api.github.com/user"
            headers: headers
          ).node login: logStarredRep(headers)

