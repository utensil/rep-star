class GithubAPI
  constructor: (access_token) ->
    @access_token = access_token

  @create: (option) ->
    api = null
    if option?.oauth_key
      OAuth.initialize oauth_key
      api = @authorize().then (access_token) ->
        new GithubAPI(access_token)

    if option?.access_token
      api = Q(new GithubAPI(option.access_token))

    api

  @authorize: ()->
    deferred = Q.defer()

    OAuth.popup "github", (error, result) ->
      if error
        deferred.reject new Error(error)
      else
        access_token = result.access_token
        deferred.resolve access_token

    deferred.promise
  
