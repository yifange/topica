app = angular.module("topicaApp")
app.controller "LoginController", [
  'Configs',
  '$http',
  '$scope',
  'authService',
  'UserSession',
  (Configs, $http, $scope, authService, UserSession) ->
    $scope.credential = {email: "", password: ""}
    $scope.submit = ->
      UserSession.login($scope.credential.email, $scope.credential.password).then (response) ->
          user = response.data.user
          authService.loginConfirmed user
      , (error) ->
          $scope.message = "Invalid username or password."
]
