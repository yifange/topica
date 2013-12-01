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
      $scope.posts[index].commentOpen = !$scope.posts[index].commentOpen
      if $scope.posts[index].commentOpen
        Restangular.one("posts", $scope.posts[index].id).getList("comments").then (comments) ->
          $scope.posts[index].comments = comments
    $scope.commentIsOpen = (index) ->
      !!$scope.posts[index].commentOpen

    $scope.toggleNewComment = (index) ->
      $scope.posts[index].newCommentOpen = !$scope.posts[index].newCommentOpen

    $scope.newCommentIsOpen = (index) ->
      !!$scope.posts[index].newCommentOpen
]
