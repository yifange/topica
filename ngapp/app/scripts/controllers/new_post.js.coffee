app = angular.module("topicaApp")
app.controller "NewPostController", [
  "Restangular",
  "$scope",
  "Configs",
  "UserSession",
  "$http",
  "$rootScope",
  # XXX fake user id
  (Restangular, $scope, Configs, UserSession, $http, $rootScope) ->
    Restangular.one("users", "1").getList("topics").then (topics) ->
      $scope.topics = []
      for i in [0..topics.length - 1]
        console.log(topics[i])
        $scope.topics.push({id: i, text: topics[i].name, selected: false})
    # $scope.topics = [
    #   {id: 0, text: "Sports", selected: false}
    #   {id: 1, text: "Movies", selected: false}
    #   {id: 2, text: "Games", selected: false}
    #   {id: 3, text: "Photography", selected: false}
    #   {id: 4, text: "Linux", selected: false}
    #   {id: 5, text: "Algorithm", selected: false}
    #   {id: 6, text: "Webdev", selected: false}
    # ]

    $scope.newPost = {}
    $scope.createNewPost = () ->
      console.log("create new post")
      $http.post(Configs.apiRoot + "/users/"+ $rootScope.userSession.user.id + "/posts/", {
        title: $scope.newPost.title,
        content: $scope.newPost.content,
      }).then (response) ->
        scope = angular.element(document.getElementById("main-view")).scope()
        $scope.newPost = response.data
        $scope.newPost.user = $rootScope.userSession.user
        $scope.newPost.num_of_comments = 0
        scope.posts.unshift($scope.newPost)

        $scope.newPost = {}
]
