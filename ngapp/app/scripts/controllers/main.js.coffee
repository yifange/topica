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
    $scope.user = UserSession.getSession()

    Restangular.all("home").getList().then (topics) ->
      console.log(topics)
      posts = []
      for topic in topics
        t_posts = topic.posts
        for post in t_posts
          post.user = topic.user
        posts.push t_posts
      $scope.posts = _.flatten(posts)
      console.log($scope.posts)
      #XXX here here

    # $scope.deletePost = () ->
    #   $http.post(Configs.apiRoot + "/users/" + $rootScope.user.id)
    # Restangular.all("users").getList().then (users) ->
    #   $scope.users = users

    $scope.toggleComments = (index) ->
      commentOpenStates[index] = !commentOpenStates[index]
      if commentOpenStates[index]
        Restangular.one("posts", $scope.posts[index].id).getList("comments").then (comments) ->
          $scope.posts[index].comments = comments
          $scope.posts[index].comment_size = comments.length if $scope.posts[index].comment_size != comments.length

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
        user_id: $scope.user.id
      }).then (comment) ->
        $scope.posts[index].newComment = ""
        comment.user = $scope.user
        if !$scope.posts[index].comments
          $scope.posts[index].comments = []
        $scope.posts[index].comments.push comment
        $scope.posts[index].comment_size += 1

    $scope.commentLoseFocus = ->
      $scope.focusComment = false
]
