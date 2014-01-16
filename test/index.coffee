require "./test.coffee"

api = require("../dist/api.js")
rep_star = api.app

# run the tests
rep_star (app) ->
  it "Should have proper initial values", () ->
    github_api = app.api
    console.log github_api
    assert github_api != null, "github_api == null"
    assert Q.isPromise(github_api), "github_api isn't a promise"

    github_api.invoke 'onUser', (errorThrown, data, jqXHR) ->
      assert(errorThrown == null, "onUser error")
      assert(data != null, "onUser data null")

    github_api.invoke('user').then( (user) ->
      #console.log user
      assert user["login"] == "utensil-dummy", "user login incorrect"
    ).done()

rep_star(
  github_params:
    access_token: "ae93c8acd01729c031da017c50f484880c7c1387"
)
