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
    $scope.email = "irfan.1989@gmail.com"
    UserSession.currentUser().then (response) ->
      $rootScope.userSession.user = response.data
    , (error) ->
      $rootScope.userSession.user = {"username": "user"}

    Restangular.all("home").getList().then (posts) ->
      $scope.posts = posts

    $scope.deletePost = () ->
      $http.post(Configs.apiRoot + "/users/" + $rootScope.userSession.user.id)
    Restangular.all("users").getList().then (users) ->
      $scope.users = users
]
