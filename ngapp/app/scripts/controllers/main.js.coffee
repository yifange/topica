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

    Restangular.one("users", $scope.user.id).all("topics").getList().then (topics) ->
      $rootScope.topics = ({id: item.id, text: item.name, selected: false} for item in topics)
]
