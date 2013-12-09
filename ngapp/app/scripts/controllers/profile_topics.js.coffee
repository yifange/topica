app = angular.module('topicaApp')
app.controller "ProfileTopicsController", [
  "Restangular",
  "UserSession",
  "$scope",
  "Configs",
  (Restangular, UserSession, $scope, Configs) ->
    $scope.baseUrl = Configs.apiRoot
    $scope.user = UserSession.getSession()
    Restangular.one("users", $scope.user.id).all("detailed_topics").getList().then (topics) ->
      $scope.topics = topics

    $scope.showPosts = (topicId) ->
      if topicId == $scope.openningPostTopic
        $scope.openningPostTopic = undefined
      else
        $scope.openningPostTopic = topicId
      Restangular.one("topics", topicId).all("posts").getList().then (posts) ->
        _.find($scope.topics, (topic) ->
          topic.id is topicId
        ).posts = posts

]
