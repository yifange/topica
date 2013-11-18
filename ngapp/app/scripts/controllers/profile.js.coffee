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
    UserSession.currentUser().then (response) ->
      $rootScope.userSession.user = response.data
    , (error) ->
      $rootScope.userSession.user = {"username": "user"}

    Restangular.one("users",$scope.userSession.user.id).all("posts").getList().then (posts) ->
      $scope.posts = posts

    Restangular.one("users",$scope.userSession.user.id).all("topics").getList().then (topics) ->
      $scope.topics = topics
]
