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
    UserSession.currentUser().then (response) ->
      $rootScope.userSession.user = response.data
    , (error) ->
      $rootScope.userSession.user = {"username": "user"}

    Restangular.all("home").getList().then (posts) ->
      $scope.posts = posts

    $scope.deletePost = () ->
      $http.post(Configs.apiRoot + "/users/" + $rootScope.userSession.user.id)
]
