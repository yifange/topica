app = angular.module("topicaApp")
app.controller "ProfileController", [
  "Restangular",
  "$scope",
  "$http",
  "Configs",
  "$location",
  "$rootScope",
  "UserSession",
  (Restangular, $scope, $http, Configs, $location, $rootScope, UserSession) ->
    $scope.user = UserSession.getSession()
    Restangular.one("users", $scope.user.id).all("posts").getList().then (posts) ->
      $scope.posts = posts

    Restangular.one("users", $scope.user.id).all("topics").getList().then (topics) ->
      $scope.topics = topics
]
