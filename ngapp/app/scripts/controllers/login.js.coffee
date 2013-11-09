app = angular.module("topicaApp")
app.controller "LoginController", ['Configs', '$http', '$scope', 'authService', (Configs, $http, $scope, authService) ->
  $scope.credential = {email: "", password: ""}
  $scope.submit = ->
    $http.post(Configs.apiRoot + "/login", {email: $scope.credential.email, password: $scope.credential.password}).then (response) ->
      user = {}
      user.id = response.data.id
      user.email = response.data.email
      user.username = response.data.username
      console.log(user.username)
      authService.loginConfirmed(user)
    , (error) ->
      $scope.message = "Invalid username or password."
]
