app = angular.module("topicaApp")
app.controller "NewPostController", [
  "$scope",
  "Configs",
  "UserSession",
  ($scope, Configs, UserSession) ->
    console.log("hello")
    $scope.showSelectedTopics = ->
      console.log($scope.topics)
    $scope.topics = [
      {id: 0, text: "Sports", selected: false}
      {id: 1, text: "Movies", selected: false}
      {id: 2, text: "Games", selected: false}
    ]
    $scope.createNewPost = () ->
      console.log("create new post")
      $http.post(Configs.apiRoot + "/post", {
        user_id: UserSession.currentUser(),
        title: $scope.postTitle,
        content: $scope.postContent,
        topic: "Music"
      })
]
