app = angular.module("topicaApp")
app.controller "LoginController", ['Configs', '$http', '$scope', (Configs, $http, $scope) ->
  $scope.credential = {email: "", password: ""}
  $scope.submit = ->
    $http.post(Configs.apiRoot + "/login", {email: $scope.credential.email, password: $scope.credential.password}).success ->
      alert "login success"
    .error ->
      alert "login failed"
]
