app = angular.module('topicaApp')
app.controller "ProfileTopicsController", [
  "Restangular",
  "UserSession",
  "$scope",
  "Configs",
  "$routeParams",
  (Restangular, UserSession, $scope, Configs, $routeParams) ->
    $scope.baseUrl = Configs.apiRoot
    $scope.user = UserSession.getSession()
    $scope.profileId = $routeParams.profileId
    Restangular.one("users", $scope.profileId).all("detailed_topics").getList().then (topics) ->
      $scope.topics = topics

    $scope.isTopicCardCollapsed = (topicId) ->
      ($scope.openningPostTopic isnt undefined) and ($scope.openningPostTopic isnt topicId)

    $scope.showPosts = (topicId) ->
      if topicId == $scope.openningPostTopic
        $scope.openningPostTopic = undefined
      else
        Restangular.one("topics", topicId).all("posts").getList().then (posts) ->
          _.find($scope.topics, (topic) ->
            topic.id is topicId
          ).posts = posts
          $scope.openningPostTopic = topicId

]
