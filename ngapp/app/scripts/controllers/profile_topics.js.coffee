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
              console.log "not following"
            else
              console.log "following"
              topic.following = true
              feedId = followship.feed_id
              topic.followshipId = followship.id
              console.log topic.followshipId
              feed = (_.find $scope.feeds, (feed) ->
                feed.id == feedId
              )
              if feed isnt undefined
                topic.selected = {id: feed.id, name: feed.name}
                console.log topic.selected
          console.log $scope.topics
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
