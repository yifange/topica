app = angular.module("topicaApp")
app.controller "SignupController", [
  'Configs',
  '$http',
  '$scope',
  (Configs, $http, $scope) ->
    console.log("signin")
]
