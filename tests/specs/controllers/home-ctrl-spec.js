define(['chai', 'angular-mocks', 'controllers/home-ctrl'], function (chai) {
describe('home', function () {

    // wanna use chai assertions? enable it.
    var expect = chai.expect;

    var scope, subject;

    beforeEach(function () {

       module('app.controllers');

       inject(function ($rootScope, $controller) {
           scope = $rootScope.$new();
           subject = $controller('homeCtrl', {$scope: scope});
       });
   });

   describe('check if controller is on it\'s place', function(){
       it('should have loaded the subject', function(){
           expect(subject).to.exist;
       });
   });

   describe('check if scope is also on it\'s place', function () {
       it('should test scope to be defined', function () {
           expect(scope).to.exist;
       });
   });

});
});