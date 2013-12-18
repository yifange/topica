###*
* @doc overview
* @id profile_posts_controller
* @name topicaApp.controllers:ProfilePostsController
* @description Show a user's all posts in profile page
*
* Route:
* /profile/:profileId/posts
###

app = angular.module('topicaApp')
app.controller "ProfilePostsController", [
  "Restangular",
  "UserSession",
  "$scope",
  "Configs",
  "$routeParams",
  (Restangular, UserSession, $scope, Configs, $routeParams) ->
    $scope.baseUrl = Configs.apiRoot
    $scope.user = UserSession.getSession()
    $scope.profileId = $routeParams.profileId

    # Fetch a user's all posts from the server
    # GET /users/:user_id/posts
    Restangular.one("users", $scope.user.id).all("posts").getList().then (posts) ->
      console.log(posts)
      $scope.posts = posts
    # Fetch a user's all topics from the server
    # This is used in the topic badges
    # GET /users/:user_id/detailed_topics
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
