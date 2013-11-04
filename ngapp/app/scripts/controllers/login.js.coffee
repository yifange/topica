app = angular.module("topicaApp")
app.controller "LoginController", ["$scope", "authService", ($scope) ->
  console.log("this is user session controller")]
