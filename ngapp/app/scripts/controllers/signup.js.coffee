###*
* @doc overview
* @id signup_controller
* @name topicaAll.controllers:SignupController
* @description Controller for the signup view
* The input boxes are binded to $scope.credential.
*
* Route:
* /signup
* Provides signup functionality
###
app = angular.module("topicaApp")
app.controller "SignupController", [
  'Configs',
  '$http',
  '$scope',
  'UserSession',
  'authService',
  (Configs, $http, $scope, UserSession, authService) ->
    $scope.credential = {}
    $scope.submittable = false
    passwordMatched = true
    # Check if the email and password are entered and if the password and password confirmation match.
    # Disable the submit button when not.
    $scope.checkSubmittable = ->
      # Check if submittable
      $scope.submittable =
        ($scope.credential.email && ($scope.credential.email != "")) and
        ($scope.credential.username && ($scope.credential.username != "")) and
        ($scope.credential.password && ($scope.credential.password != "")) and
        ($scope.credential.passwordConfirmation && ($scope.credential.passwordConfirmaion != ""))
      if $scope.credential.password and $scope.credential.passwordConfirmation != $scope.credential.password
        passwordMatched = false
      else
        passwordMatched = true
      $scope.submittable &= passwordMatched

      if !passwordMatched
        $scope.message = "Password not match."
      else
        $scope.message = ""
    # Submit the email and password to the server
    $scope.submit = ->
      # POST /signup
      $http.post(Configs.apiRoot + "/signup", {
        "email": $scope.credential.email,
        "password": $scope.credential.password,
        "password_confirmation": $scope.credential.passwordConfirmation,
        "username": $scope.credential.username
      }).then (response) ->
        # If the request fails, show error messages
        UserSession.login($scope.credential.email, $scope.credential.password). then (response) ->
          user = response.data.user
          authService.loginConfirmed user
        , (error) ->
          $scope.message = "Invalid username or password"
      , (error) ->
        console.log(error)
        $scope.message = error.data.message
]
