app = angular.module("topicaApp")
app.controller "LoginController", ['Configs', '$http', '$scope', 'authService', (Configs, $http, $scope, authService) ->
  $scope.credential = {email: "", password: ""}
  $scope.submit = ->
    $http.post(Configs.apiRoot + "/login", {email: $scope.credential.email, password: $scope.credential.password}).then (response) ->
      authService.loginConfirmed(response.data.id)
    , (error) ->
      $scope.message = "Invalid username or password."
]
