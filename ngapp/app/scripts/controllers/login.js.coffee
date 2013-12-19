###*
* @doc overview
* @id login_controller
* @name topicaApp.controllers:LoginController
* @description The login controller.
*
* The controller of the login view.
* View calls submit funtion to login. $scope.credential is bind to the email input and password input.
* When login is successful, call loginConfirmed method authService module.
* A login confirmed event will be broadcasted.
*
* Route: /login
*
###

app = angular.module("topicaApp")
app.controller "LoginController", [
  'Configs',
  '$http',
  '$scope',
  'authService',
  'UserSession',
  (Configs, $http, $scope, authService, UserSession) ->
    # redirect if the user has logged in
    $scope.credential = {email: "", password: "", rememberMe: false}
    # Submit the login credentials.
    $scope.submit = ->
      UserSession.login($scope.credential.email, $scope.credential.password, $scope.credential.rememberMe).then (response) ->
          user = response.data.user
          authService.loginConfirmed user
      , (error) ->
          $scope.message = "Invalid username or password."
]
