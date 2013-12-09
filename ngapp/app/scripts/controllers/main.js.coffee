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
    $scope.user = UserSession.getSession()
    $scope.baseUrl = Configs.apiRoot
    Restangular.all("home").getList().then (posts) ->
      $scope.posts = posts

]
