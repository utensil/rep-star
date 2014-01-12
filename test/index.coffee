require "./test.coffee"

api = require("../dist/api.js")
rep_star = api.app

# run the tests
rep_star (app) ->
  it "Should have proper initial values", () ->
    github_user = app.user
    #console.log github_user
    assert github_user != null, "github_user == null"
    assert Q.isPromise(github_user), "github_user isn't a promise"

rep_star(
  github_params:
    access_token: "ae93c8acd01729c031da017c50f484880c7c1387"
)
