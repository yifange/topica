app = angular.module("topicaApp")
app.controller "NewPostController", [
  "Restangular",
  "$scope",
  "Configs",
  "UserSession",
  "$http",
  (Restangular, $scope, Configs, UserSession, $http) ->
    $scope.user = UserSession.getSession()
    $scope.baseUrl = Configs.apiRoot
    $scope.newPost = {}
    $scope.itemTemplate = {
      user_id: $scope.user.id
      topic_type: 1
    }
    $scope.createNewPost = () ->
      # collect the selected topics' ids
      $scope.selectedTopicIds = _.map _.filter($scope.topics, 'selected'), (topic) ->
        topic.id
      # user id deleted from url
      $http.post(Configs.apiRoot + "/posts/", {
        title: $scope.newPost.title,
        content: $scope.newPost.content,
        topic_ids: $scope.selectedTopicIds
      }).then (response) ->
        scope = angular.element(document.getElementById("main-view")).scope()
        $scope.newPost = response.data
        $scope.newPost.user = $scope.user
        $scope.newPost.num_of_comments = 0
        $scope.newPost.topics = _.map _.filter($scope.topics, 'selected'), (topic) ->
          {
            id: topic.id
            name: topic.text
            topic_type: topic.topic_type
          }
        scope.posts.unshift($scope.newPost)

        $scope.newPost = {}
      $scope.edit = false

    $scope.addItem = (item) ->
      console.log(item)
]
