define [
  './index'
  'oauth'
  'oboe'
  'jquery'
  'perfect-scrollbar'
], (controllers, OAuth, oboe, $, ps) ->
  "use strict"
  controllers.controller "repInfoCtrl",
  ($scope, $routeParams, $timeout, $localStorage, $sessionStorage, $window) ->
    $scope.$storage = $localStorage
    $scope.current_rep = $sessionStorage.current_rep
    $scope.readme = ""

    $scope.close = ->
      $window.history.back()


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

    $scope.github_auth_result = $scope.$storage['github_auth_result']
    $scope.github_user = $scope.$storage['github_user'] 

    if $scope.github_user
      access_token = $scope.github_auth_result.access_token
      $scope.access_token = access_token
      whenHaveRepReadMe access_token, $scope.current_rep.full_name, (err, data)->
        #console.log data
        #rep_info = $('#rep-info')
        #readme_element = $('.rep-readme', rep_info)
        #readme_element.html(data)
        $timeout ->
          $scope.readme = data
