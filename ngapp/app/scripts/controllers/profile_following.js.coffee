###*
* @doc overview
* @id profile_following_controller
* @name topicaApp.controllers:ProfileFollowingController
* @description The controller for the following topics
*
* Show all the following topics
* Route:
* /profile/:profileId/following
###
app = angular.module('topicaApp')
app.controller "ProfileFollowingController", [
  "Restangular",
  "UserSession",
  "$scope",
  "$routeParams",
  (Restangular, UserSession, $scope, $routeParams) ->
    $scope.user = UserSession.getSession()
    $scope.profileId = $routeParams.profileId
    $scope.topicId = $routeParams.topicId
    Restangular.one("users", $scope.profileId).all("following_topics").getList().then (topics) ->
      $scope.topics = topics
]
