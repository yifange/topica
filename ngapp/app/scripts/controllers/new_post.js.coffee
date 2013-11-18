app = angular.module("topicaApp")
app.controller "NewPostController", [
  "$scope",
  "Configs",
  "UserSession",
  "$http",
  "$rootScope",
  ($scope, Configs, UserSession, $http, $rootScope) ->
    $scope.topics = [
      {id: 0, text: "Sports", selected: false}
      {id: 1, text: "Movies", selected: false}
      {id: 2, text: "Games", selected: false}
    ]

    $scope.newPost = {}
    $scope.createNewPost = () ->
      console.log("create new post")
      $http.post(Configs.apiRoot + "/users/"+ $rootScope.userSession.user.id + "/posts/", {
        title: $scope.newPost.title,
        content: $scope.newPost.content,
      }).then (response) ->
        scope = angular.element(document.getElementById("main-view")).scope()
        scope.posts.unshift($scope.newPost)
        $scope.newPost = {}
]
