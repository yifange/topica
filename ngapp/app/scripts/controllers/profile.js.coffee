app = angular.module("topicaApp")
app.controller "ProfileController", [
  "Restangular",
  "$scope",
  "$location",
  "UserSession",
  "$routeParams",
  (Restangular, $scope, $location, UserSession, $routeParams) ->
    console.log("hello about")
    $scope.user = UserSession.getSession()
    activePage = 'topics'
    $scope.isActivePage = (page) ->
      activePage is page
    console.log $routeParams.profileId
    $scope.goto = (page) ->
      path = "/profile/" + $scope.profileId + "/" + page
      $location.path(path)

]
