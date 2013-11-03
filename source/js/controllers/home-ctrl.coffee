define [
  './index'
  'oauth'
  'oboe'
  'jquery'
  'perfect-scrollbar'
  'jquery.bpopup'
], (controllers, OAuth, oboe, $, ps, bp) ->
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
          store_set 'github_auth_result', result

          headers =
            Authorization: "token #{access_token}"

          oboe(
            method: 'GET'
            url: "https://api.github.com/user"
            headers: headers
          ).node
            "$![*]": (data) ->
              login = data['login']
              store_set 'github_user', data            
              logStarredRep(access_token)(login)

    $scope.popup = (rep) ->
      $scope.current_rep = rep
      #.height($(window).height() * 0.8)

      rep_info = $('#rep-info')
      readme_element = $('.rep-readme', rep_info)

      if($(window).width() <= 480)
        wdith =  $(window).width() * 0.9        
        height = $('#reps').height()
      else
        wdith = $('#reps').width()          
        height = Math.min $('#reps').height(), $(window).height()

      rep_info.width(wdith).height(height)
      readme_element.width(wdith * 0.95).height(height * 0.8)

      rep_info.bPopup(
        #positionStyle: 'fixed'
        scrollBar: true
        position: ['auto', 'auto']
        follow: [true, false]
        closeClass: 'close-handle'
        onOpen: () ->
          $(this).removeClass('hide')
          access_token = $scope.access_token          
          console.log readme_element
          whenHaveRepReadMe access_token, rep.full_name, (err, data)->
            readme_element.html(data)
            readme_element.
            perfectScrollbar(
              wheelPropagation: true
              wheelSpeed: 100
              minScrollbarLength: 20
            )

        onClose: () ->          
          $(this).addClass('hide')
          $('.rep-readme', this).html('');          
        #content:'iframe'
        #loadUrl: "#/rep-info/#{rep.owner.login}/#{rep.name}"
        #contentContainer: '.rep-readme'
        #loadData:
        #content:'image'
        #loadUrl: '/assets/images/rep-star.png'
      )

    $('#reps').height($(window).height()).
    perfectScrollbar(
      wheelPropagation: true
      wheelSpeed: 100
      minScrollbarLength: 20
    )

    $scope.github_auth_result = store_get 'github_auth_result'
    $scope.github_user = store_get 'github_user'

    if $scope.github_user
      access_token = $scope.github_auth_result.access_token
      $scope.access_token = access_token
      logStarredRep(access_token)($scope.github_user.login)





      




