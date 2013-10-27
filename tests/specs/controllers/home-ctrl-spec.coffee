define [
  "chai"
  "angular-mocks"
  "controllers/home-ctrl"
], (chai) ->
  describe "home", ->

    # wanna use chai assertions? enable it.
    expect = chai.expect
    scope = undefined
    subject = undefined
    beforeEach ->
      module "app.controllers"
      inject ($rootScope, $controller) ->
        scope = $rootScope.$new()
        subject = $controller("homeCtrl",
          $scope: scope
        )


    describe "check if controller is on it's place", ->
      it "should have loaded the subject", ->
        expect(subject).to.exist


    describe "check if scope is also on it's place", ->
      it "should test scope to be defined", ->
        expect(scope).to.exist