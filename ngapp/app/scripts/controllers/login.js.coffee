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
          user = {}
          user.id = response.data.id
          user.email = response.data.email
          user.username = response.data.username
          authService.loginConfirmed user
      , (error) ->
          $scope.message = "Invalid username or password."
]
