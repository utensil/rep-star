define [
  './index'
  'oauth'
  'jquery'
  'perfect-scrollbar'
], (controllers, OAuth, $, ps) ->
  "use strict"
  controllers.controller "homeCtrl", 
  ($scope, $timeout, $location, $localStorage, $sessionStorage) ->
    $scope.$storage = $localStorage

    onUser = (access_token, cb) ->
      headers =
        Authorization: "token #{access_token}"

      user_api = $.ajax(
        method: 'GET'
        url: "https://api.github.com/user"
        headers: headers
        success: (data, textStatus, jqXHR) ->
          cb(null, data, jqXHR)
        error: ( jqXHR, textStatus, errorThrown) ->
          cb(errorThrown, null, jqXHR)
      )

    loadUser = (access_token) ->
      onUser access_token, (err, data, jqXHR) ->
        if err
          #FIXME
        else
          login = data['login']
          $scope.$storage['github_user'] = data
          console.log 'to dashboard'
          $timeout ->
            $location.path 'dashboard'
        
    $scope.authGithub = ->
      OAuth.popup "github", (error, result) ->
        console.log error, result
        unless error
          access_token = result.access_token
          $scope.access_token = access_token
          $scope.$storage['github_auth_result'] = result
          loadUser access_token

    $scope.github_auth_result = $scope.$storage['github_auth_result']
    $scope.github_user = $scope.$storage['github_user'] 

    if $scope.github_user
      $location.path 'dashboard'






      




