define [
  "./index"
  "oauth"
  "jquery"
], (controllers, OAuth, $) ->
  "use strict"
  controllers.controller "homeCtrl", ($scope, $timeout) ->
    $scope.blah = "4"
    $scope.reps = []

    store_set = (key, value) ->
      localStorage.setItem key, JSON.stringify(value)

    store_get = (key) ->
      return JSON.parse(localStorage.getItem(key))

    logStarredRep = (access_token) ->
      (login) ->
        #console.log login
        headers = Authorization: "token #{access_token}"

        jqXHR = $.ajax "https://api.github.com/users/#{login}/starred",
          headers: headers
          dataType: 'json'
        jqXHR.done (data, textStatus, xhr) ->
          $timeout ->
            $scope.reps = data         
    $scope.authGithub = ->
      OAuth.popup "github", (error, result) ->
        console.log error, result
        unless error
          access_token = result.access_token
          store_set 'github_auth_result', result

          headers = Authorization: "token #{access_token}"

          jqXHR = $.ajax "https://api.github.com/user",
            headers: headers
            dataType: 'json'

          jqXHR.done (data, textStatus, xhr) ->
            login = data['login']
            store_set 'github_user', data            
            logStarredRep(access_token)(login)

    $scope.github_auth_result = store_get 'github_auth_result'
    $scope.github_user = store_get 'github_user'

    if $scope.github_user
      access_token = $scope.github_auth_result.access_token
      logStarredRep(access_token)($scope.github_user.login)





      




