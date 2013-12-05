app = angular.module("topicaApp")
app.controller "NewPostController", [
  "Restangular",
  "$scope",
  "Configs",
  "UserSession",
  "$http",
  "$rootScope",
  # XXX fake user id
  # get a user's topic from backend using Restangular
  (Restangular, $scope, Configs, UserSession, $http, $rootScope) ->
    Restangular.one("users", "1").getList("topics").then (topics) ->
      $scope.topics = []
      for i in [0..topics.length - 1]
        $scope.topics.push({id: i, text: topics[i].name, selected: false})

    $scope.newPost = {}
    $scope.createNewPost = () ->
      # collect the selected topics' ids
      $scope.selected_topics_ids = []
      for i in [0..$scope.topics.length - 1]
        if $scope.topics[i].selected == true
          $scope.selected_topics_ids.push($scope.topics[i].id)
      # user id deleted from url
      $http.post(Configs.apiRoot + "/posts/", {
        title: $scope.newPost.title,
        content: $scope.newPost.content,
        topic_ids: $scope.selected_topics_ids
      }).then (response) ->
        scope = angular.element(document.getElementById("main-view")).scope()
        $scope.newPost = response.data
        $scope.newPost.user = $rootScope.userSession.user
        $scope.newPost.num_of_comments = 0
        scope.posts.unshift($scope.newPost)

        $scope.newPost = {}
]
