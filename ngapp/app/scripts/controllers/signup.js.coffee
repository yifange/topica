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
    $scope.checkSubmittable = ->
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
    $scope.submit = ->
      $http.post(Configs.apiRoot + "/signup", {
        "email": $scope.credential.email,
        "password": $scope.credential.password,
        "password_confirmation": $scope.credential.passwordConfirmation,
        "username": $scope.credential.username
      }).then (response) ->
        UserSession.login($scope.credential.email, $scope.credential.password). then (response) ->
          user = response.data.user
          authService.loginConfirmed user
        , (error) ->
          $scope.message = "Invalid username or password"
      , (error) ->
        console.log(error)
        $scope.message = error.data.message




]
