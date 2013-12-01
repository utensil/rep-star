define [
  './index'
  'oauth'
  'jquery'
  'perfect-scrollbar'
], (controllers, OAuth, $, ps) ->
  "use strict"
  controllers.controller "dashboardCtrl", 
  ($scope, $timeout, $location, $localStorage, $sessionStorage) ->
    $scope.reps = []

    $scope.$storage = $localStorage

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

    $scope.popup = (rep) ->
      $sessionStorage.current_rep = rep
      $location.path('rep-info')

    $scope.logout = () ->
      console.log('logout')
      $localStorage.$reset();
      $sessionStorage.$reset();
      $location.path ''

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
    else
      $location.path('')

