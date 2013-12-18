###*
* @doc overview
* @id new_post_controller
* @name topicaApp.controllers:NewPostController
* @description New post controller
*
* New post controller, used for the new post box partial.
###

app = angular.module("topicaApp")
app.controller "NewPostController", [
  "Restangular",
  "$scope",
  "Configs",
  "UserSession",
  "$http",
  "$rootScope"
  (Restangular, $scope, Configs, UserSession, $http, $rootScope) ->
    $scope.user = UserSession.getSession()
    $scope.baseUrl = Configs.apiRoot
    $scope.newPost = {}
    $rootScope.topics = []

    # Fetch all the topics and store in the rootscope
    Restangular.one("users", $scope.user.id).all("topics").getList().then (topics) ->
      $rootScope.topics = ({id: item.id, text: item.name, selected: false} for item in topics)

    # the item template used for pluspicker.
    # XXX need to be changed when topic type is implemented
    $scope.itemTemplate = {
      topic_type: 1
    }
    # Triggered when clicking on new post button
    $scope.createNewPost = () ->
      # collect the selected topics' ids
      $scope.selectedTopicIds = _.map _.filter($scope.topics, 'selected'), (topic) ->
        topic.id
      # POST to /users/:user_id/posts, create new post
      $http.post(Configs.apiRoot + "/posts/", {
        title: $scope.newPost.title,
        content: $scope.newPost.content,
        topic_ids: $scope.selectedTopicIds
      }).then (response) ->
        # Create a newpost object only for frontend display
        $scope.newPost = response.data
        $scope.newPost.user = $scope.user
        $scope.newPost.num_of_comments = 0
        $scope.newPost.topics = _.map _.filter($scope.topics, 'selected'), (topic) ->
          {
            id: topic.id
            name: topic.text
            topic_type: topic.topic_type
          }
        # Insert the newpost object to the post list in main-view controller
        scope = angular.element(document.getElementById("main-view")).scope()
        console.log scope
        scope.posts.unshift($scope.newPost)

        $scope.newPost = {}
      $scope.edit = false

    # XXX Not used
    $scope.addItem = (item) ->
      console.log(item)
]
