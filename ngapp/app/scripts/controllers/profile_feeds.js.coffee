###*
* @doc overview
* @id profile_feeds_controller
* @name topicaApp.controller:Profilefeedscontroller
* @description The profile feeds subpage. Used to show all the feeds of current user.
*
###

app = angular.module('topicaApp')
app.controller "ProfileFeedsController", [
  "Restangular",
  "UserSession",
  "$scope",
  "Configs",
  "$routeParams",
  (Restangular, UserSession, $scope, Configs, $routeParams) ->
    $scope.baseUrl = Configs.apiRoot
    $scope.user = UserSession.getSession()
    $scope.profileId = $routeParams.profileId
    Restangular.one("users", $scope.profileId).all("feeds").getList().then (feeds) ->
      $scope.feeds = feeds

    $scope.showTopics = (feedId) ->
      Restangular.one("feeds", feedId).all("topics").getList().then (topics) ->
        console.log(topics)
        $scope.topics = topics

  ]
