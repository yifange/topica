app = angular.module("topicaApp")
app.controller "ProfileAboutController", [
  "Restangular",
  "$scope",
  "$location",
  "UserSession",
  (Restangular, $scope, $location, UserSession) ->
    console.log("hello about")
    $scope.user = UserSession.getSession()
    activePage = 'topics'
    $scope.isActivePage = (page) ->
      activePage is page
    $scope.goto = (page) ->
      path = "/profile/" + $scope.profileId + "/" + page
      $location.path(path)

]
