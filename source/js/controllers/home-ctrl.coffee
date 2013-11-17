define [
  './index'
  'oauth'
  'oboe'
  'jquery'
  'perfect-scrollbar'
], (controllers, OAuth, oboe, $, ps) ->
  "use strict"
  controllers.controller "homeCtrl", ($scope, $timeout, $location, $localStorage, $sessionStorage) ->
    $scope.blah = "4"
    $scope.reps = []

    $scope.$storage = $localStorage

    logStarredRep = (access_token) ->
      (login) ->
        #caches results
        if $sessionStorage.reps
          $timeout ->
            $scope.reps = $sessionStorage.reps
          return

        #console.log login
        headers =
          Authorization: "token #{access_token}"

        starred_api = oboe(
          method: 'GET'
          #sort
          #   Optional String One of created (when the repository was starred) 
          #   or updated (when it was last pushed to). Default: created.
          #direction
          #   Optional String One of asc or desc. Default: desc.
          url: "https://api.github.com/users/#{login}/starred?sort=created"
          headers: headers
        )

        starred_api.start (_, headers)->
          console.log headers['Link'] 

        starred_api.node
          "$![*]": (data) ->                       
            $timeout ->
              $scope.reps = data
              $sessionStorage.reps = data

    whenHaveRepReadMe = (access_token, rep_fullname, cb) ->
      headers =
        Authorization: "token #{access_token}"
        #Accept: 'application/vnd.github.v3.raw+json'
        Accept: 'application/vnd.github.v3.html+json'

      readme_api = $.ajax(
        method: 'GET'
        url: "https://api.github.com/repos/#{rep_fullname}/readme"
        dataType: 'html'
        headers: headers
        success: (data, textStatus, jqXHR) ->
          cb(null, data)
        error: ( jqXHR, textStatus, errorThrown) ->
          cb(errorThrown, null)
      )
        
    $scope.authGithub = ->
      OAuth.popup "github", (error, result) ->
        console.log error, result
        unless error
          access_token = result.access_token
          $scope.access_token = access_token
          $scope.$storage['github_auth_result'] = result

          headers =
            Authorization: "token #{access_token}"

          oboe(
            method: 'GET'
            url: "https://api.github.com/user"
            headers: headers
          ).node
            "$![*]": (data) ->
              login = data['login']
              $scope.$storage['github_user'] = data            
              logStarredRep(access_token)(login)

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
      logStarredRep(access_token)($scope.github_user.login)





      




