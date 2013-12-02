app = angular.module("topicaApp")
app.controller 'MainController', [
  "Restangular",
  "$scope",
  "$http",
  "Configs",
  "$location",
  "$rootScope",
  "UserSession",
  (Restangular, $scope, $http, Configs, $location, $rootScope, UserSession) ->
    $scope.newComment = []
    commentOpenStates = []
    newCommentOpenStates = []
    UserSession.currentUser().then (response) ->
      $rootScope.userSession.user = response.data
    , (error) ->
      $rootScope.userSession.user = {"username": "user"}

    Restangular.all("home").getList().then (posts) ->
      $scope.posts = posts

    $scope.deletePost = () ->
      $http.post(Configs.apiRoot + "/users/" + $rootScope.userSession.user.id)
    Restangular.all("users").getList().then (users) ->
      $scope.users = users

    $scope.toggleComments = (index) ->
      commentOpenStates[index] = !commentOpenStates[index]
      if commentOpenStates[index]
        Restangular.one("posts", $scope.posts[index].id).getList("comments").then (comments) ->
          $scope.posts[index].comments = comments
          $scope.posts[index].num_of_comments = comments.length if $scope.posts[index].num_of_comments != comments.length

    $scope.commentIsOpen = (index) ->
      !!commentOpenStates[index]

    $scope.toggleNewComment = (index) ->
      newCommentOpenStates[index] = !newCommentOpenStates[index]
      if !newCommentOpenStates[index]
        $scope.posts[index].newComment = ""

    $scope.newCommentIsOpen = (index) ->
      !!newCommentOpenStates[index]

    $scope.submitComment = (index) ->
      Restangular.one("posts", $scope.posts[index].id).all("comments").post({
        content: $scope.posts[index].newComment,
        user_id: $rootScope.userSession.user.id
      }).then (comment) ->
        $scope.posts[index].newComment = ""
        comment.user = $rootScope.userSession.user
        if !$scope.posts[index].comments
          $scope.posts[index].comments = []
        $scope.posts[index].comments.push comment
        $scope.posts[index].num_of_comments += 1
]
