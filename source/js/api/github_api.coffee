class GithubAPI
  constructor: (access_token, option = {}) ->
    @access_token = access_token
    @option = option
    @login = null
    @github_user = null

  @create: (option) ->
    api = null
    if option?.oauth_key
      OAuth.initialize option.oauth_key
      api = @authorize().then (access_token) ->
        new GithubAPI(access_token, option)

    if option?.access_token
      api = Q(new GithubAPI(option.access_token, option))

    api

  # only runs in browser
  @authorize: ()->
    deferred = Q.defer()

    OAuth.popup "github", (error, result) ->
      if error
        deferred.reject new Error(error)
      else
        access_token = result.access_token
        deferred.resolve access_token

    deferred.promise
  
  onUser : (cb) ->
    headers =
      Authorization: "token #{@access_token}"
  
    user_api = $.ajax(
      method: 'GET'
      url: "https://api.github.com/user"
      headers: headers
      success: (data, textStatus, jqXHR) ->
        cb(null, data, jqXHR)
      error: ( jqXHR, textStatus, errorThrown) ->
        cb(errorThrown, null, jqXHR)
    )

  user : () ->
    deferred = Q.defer()

    @onUser (err, data, jqXHR) ->
      if err
        deferred.reject new Error(err)
      else
        #console.log err, data
        data = JSON.parse(data)
        @login = data['login']
        @github_user = data
        deferred.resolve @github_user
        #console.log login, github_user

    deferred.promise

