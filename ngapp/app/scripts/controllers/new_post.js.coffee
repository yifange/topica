app = angular.module("topicaApp")
app.controller "NewPostController", [
  "Restangular",
  "$scope",
  "Configs",
  "UserSession",
  "$http",
  (Restangular, $scope, Configs, UserSession, $http) ->
    user = UserSession.getSession()
    Restangular.one("users", user.id).getList("topics").then (topics) ->
      $scope.topics = ({id: topic.id, text: topic.name, selected: false} for topic in topics)

    $scope.newPost = {}
    $scope.createNewPost = () ->
      # collect the selected topics' ids
      $scope.selected_topic_ids = _.map _.filter($scope.topics, 'selected'), (topic) ->
        topic.id
      # user id deleted from url
      $http.post(Configs.apiRoot + "/posts/", {
        title: $scope.newPost.title,
        content: $scope.newPost.content,
        topic_ids: $scope.selected_topic_ids
      }).then (response) ->
        scope = angular.element(document.getElementById("main-view")).scope()
        $scope.newPost = response.data
        $scope.newPost.user = user
        $scope.newPost.num_of_comments = 0
        scope.posts.unshift($scope.newPost)

        $scope.newPost = {}
      $scope.edit = false
]
