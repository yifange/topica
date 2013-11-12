app = angular.module("topicaApp")
app.controller 'MainController', [
  "Restangular",
  "$scope",
  "$http",
  "Configs",
  "$location",
  "$rootScope",
  "UserSession",
  (Restangular, $scope, $http, Configs, $location, $rootScope, UserSession) ->
    $http.get(Configs.apiRoot + "/me").then (response) ->
      $rootScope.userSession.user = response.data
    Restangular.all("home").getList().then (posts) ->
      $scope.user = $rootScope.userSession.user
      $scope.posts = posts
]
