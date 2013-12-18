###*
* @doc overview
* @id profile_topics_controller
* @name topicaApp.controllers:ProfileTopicsController
* @description The controller for the topic subpage of profile page
*
* Shows all the topics owned by a user.
* Provides functionalities like showing all posts, assigning feeds to the topics
###

app = angular.module('topicaApp')
app.controller "ProfileTopicsController", [
  "Restangular",
  "UserSession",
  "$scope",
  "Configs",
  "$routeParams",
  "$rootScope",
  (Restangular, UserSession, $scope, Configs, $routeParams, $rootScope) ->
    $scope.baseUrl = Configs.apiRoot
    $scope.user = UserSession.getSession()
    $scope.profileId = $routeParams.profileId
    # Fetch all the topics of the user
    # GET /users/:user_id/detailed_topics
    Restangular.one("users", $scope.profileId).all("detailed_topics").getList().then (topics) ->
      $scope.topics = topics
      $rootScope.topic_selections = ({id: item.id, text: item.name, selected:false} for item in topics)
      topicId = parseInt $routeParams.topicId
      if _.find $scope.topics, {id: topicId}
        $scope.openningPostTopic = topicId
        Restangular.one("topics", topicId).all("posts").getList().then (posts) ->
          _.find($scope.topics, (topic) ->
            topic.id is topicId
          ).posts = posts
      # Fetch all the feeds after the topics are fetched
      # GET /users/:user_id/feeds
      Restangular.one("users", $scope.user.id).all("feeds").getList().then (feeds) ->
        $scope.feeds = _.map feeds, (feed) ->
          {
            id: feed.id
            name: feed.name
            number: feed.topic_size
          }
        # Fetch all the topic-feed relationships after feeds are fetched
        # GET /users/:user_id/followships
        Restangular.one("users", $scope.user.id).all("followships").getList().then (followships) ->
          _.each $scope.topics, (topic) ->
            followship = (_.find followships, (followship) ->
              followship.topic_id == topic.id
            )
            # If the topic is not being followed
            if followship is undefined
              topic.following = false
            else
              # if the topic is being followed
              topic.following = true
              feedId = followship.feed_id
              topic.followshipId = followship.id
              feed = (_.find $scope.feeds, (feed) ->
                feed.id == feedId
              )
              # If the topic is already in some feed
              if feed isnt undefined
                topic.selected = {id: feed.id, name: feed.name}
            true
    $scope.isTopicCardCollapsed = (topicId) ->
      ($scope.openningPostTopic isnt undefined) and ($scope.openningPostTopic isnt topicId)
    # Show all the posts in the topic
    # Triggered when the post link is clicked
    $scope.showPosts = (topicId) ->
      if topicId == $scope.openningPostTopic
        $scope.openningPostTopic = undefined
      else
        Restangular.one("topics", topicId).all("posts").getList().then (posts) ->
          _.find($scope.topics, (topic) ->
            topic.id is topicId
          ).posts = posts
          $scope.openningPostTopic = topicId

    # unfollow a topic
    # Triggered when the "unfollow topic" link in the menu is clicked
    $scope.unfollow = (topicId) ->
      topic = (_.find $scope.topics, {id: topicId})
      topic.following = false
      (_.find $scope.feeds, {id: topic.selected.id}).number -= 1
      topic.selected = null
      Restangular.one("users", $scope.user.id).one("followships", topic.followshipId).remove()

    # follow a topic
    # Triggered when the "follow topic" link in the menu is clicked
    $scope.follow = (topicId) ->
      topic = (_.find $scope.topics, {id: topicId})
      Restangular.one("users", $scope.user.id).all("followships").post({
        topic_id: topic.id
      }).then (followship) ->
        topic.followshipId = followship.id
        topic.following = true

]
