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
      topicId = parseInt $routeParams.topicId
      if _.find $scope.topics, {id: topicId}
        $scope.openningPostTopic = topicId
        Restangular.one("topics", topicId).all("posts").getList().then (posts) ->
          _.find($scope.topics, (topic) ->
            topic.id is topicId
          ).posts = posts

      Restangular.one("users", $scope.user.id).all("feeds").getList().then (feeds) ->
        $scope.feeds = _.map feeds, (feed) ->
          {
            id: feed.id
            name: feed.name
            number: feed.topic_size
          }

        Restangular.one("users", $scope.user.id).all("followships").getList().then (followships) ->
          _.each $scope.topics, (topic) ->
            followship = (_.find followships, (followship) ->
              followship.topic_id == topic.id
            )
            if followship is undefined
              topic.following = false
            else
              topic.following = true
              feedId = followship.feed_id
              topic.followshipId = followship.id
              feed = (_.find $scope.feeds, (feed) ->
                feed.id == feedId
              )
              if feed isnt undefined
                topic.selected = {id: feed.id, name: feed.name}
            true
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
    $scope.unfollow = (topicId) ->
      topic = (_.find $scope.topics, {id: topicId})
      topic.following = false
      (_.find $scope.feeds, {id: topic.selected.id}).number -= 1
      topic.selected = null
      Restangular.one("users", $scope.user.id).one("followships", topic.followshipId).remove()
    $scope.follow = (topicId) ->
      topic = (_.find $scope.topics, {id: topicId})
      Restangular.one("users", $scope.user.id).all("followships").post({
        topic_id: topic.id
      }).then (followship) ->
        topic.followshipId = followship.id
        topic.following = true

]
