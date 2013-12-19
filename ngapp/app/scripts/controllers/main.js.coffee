app = angular.module("topicaApp")
###*
* @doc overview
* @id main_controller
* @name topicaApp.controllers:MainController
* @description The home page controller
*
* The controller for the main view. Display posts in the topics followed by the current user.
*
* Route: /
*
###

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
    # Fetch all the posts in the topics followed by the user.
    Restangular.all("home").getList().then (posts) ->
      $scope.posts = posts
    # Fetch all the topics followed by the user and store in the rootscope.
    # Used by pluspicker (new post controller & all the repost boxes in newscards)
    Restangular.one("users", $scope.user.id).all("topics").getList().then (topics) ->
      $rootScope.topics = ({id: item.id, text: item.name, selected: false} for item in topics)
]
