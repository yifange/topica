###*
* @doc overview
* @id profile_about_controller
* @name topicaApp.controllers:ProfileAboutController
* @description This is the profile_aboutcontroller.
*
###

app = angular.module("topicaApp")
app.controller "ProfileAboutController", [
  "Restangular",
  "$scope",
  "$location",
  "UserSession",
  "$routeParams",
  "ProfileActivePage"
  (Restangular, $scope, $location, UserSession, $routeParams, ProfileActivePage) ->
    $scope.user = UserSession.getSession()
    $scope.profileId = $routeParams.profileId
    $scope.profileUser = {id: $routeParams.profileId}
    Restangular.one("users", $scope.profileUser.id).get().then (user) ->
      $scope.profileUser.email = user.email
      $scope.profileUser.username = user.username

    $scope.isActivePage = (page) ->
      ProfileActivePage.getActivePage() is page
    $scope.goto = (page) ->
      ProfileActivePage.setActivePage(page)
      path = "profile/" + $scope.profileId + "/" + page
      $location.path path
]
