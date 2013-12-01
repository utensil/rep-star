define [
  './index'
  'oauth'
  'jquery'
  'perfect-scrollbar'
], (controllers, OAuth, $, ps) ->
  "use strict"
  controllers.controller "homeCtrl", ($scope, $timeout, $location, $localStorage, $sessionStorage) ->
    $scope.blah = "4"
    $scope.reps = []

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
          loadStarredRep(access_token, login)


    onStarredRep = (access_token, login, cb) ->
      #caches results
      if $sessionStorage.reps
        $timeout ->
          $scope.reps = $sessionStorage.reps
        return

      #console.log login
      headers =
        Authorization: "token #{access_token}"

      starred_api = $.ajax(
        method: 'GET'
        #sort
        #   Optional String One of created (when the repository was starred) 
        #   or updated (when it was last pushed to). Default: created.
        #direction
        #   Optional String One of asc or desc. Default: desc.
        url: "https://api.github.com/users/#{login}/starred?sort=created"
        headers: headers
        success: (data, textStatus, jqXHR) ->
          cb(null, data, jqXHR)
        error: ( jqXHR, textStatus, errorThrown) ->
          cb(errorThrown, null, jqXHR)
      )

    loadStarredRep = (access_token, login) ->
      onStarredRep access_token, login, (err, data, jqXHR)->
        if err
          #FIXME
        else
          console.log jqXHR.getResponseHeader('Link')
          $timeout ->
            $scope.reps = data
            $sessionStorage.reps = data
        
    $scope.authGithub = ->
      OAuth.popup "github", (error, result) ->
        console.log error, result
        unless error
          access_token = result.access_token
          $scope.access_token = access_token
          $scope.$storage['github_auth_result'] = result

          loadUser access_token

    $scope.popup = (rep) ->
      $sessionStorage.current_rep = rep

      $location.path('rep-info')

    $('#reps').height($(window).height()).
    perfectScrollbar(
      wheelPropagation: true
      wheelSpeed: 100
      minScrollbarLength: 20
    )

    $scope.github_auth_result = $scope.$storage['github_auth_result']
    $scope.github_user = $scope.$storage['github_user'] 

    if $scope.github_user
      access_token = $scope.github_auth_result.access_token
      $scope.access_token = access_token
      loadStarredRep(access_token, $scope.github_user.login)





      




