###*
* @doc overview
* @id profile_about_controller
* @name topicaApp.controllers:ProfileAboutController
* @description The controller used to display user info in profile page
*
* Used by all the profile subpages.
* The route may contain a profile id. (/profile/:profileId)
* If the profileId is not provided, the profile for current user will be rendered.
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
    # GET /users/:user_id
    # Get the user info for currently viewing profile page
    Restangular.one("users", $scope.profileUser.id).get().then (user) ->
      $scope.profileUser.email = user.email
      $scope.profileUser.username = user.username
    # Check if the given page is active.
    # Page names can be topics, posts, feeds, favors, following
    # XXX feeds, favors and following not implemented
    $scope.isActivePage = (page) ->
      ProfileActivePage.getActivePage() is page

    # Goto the given page
    # Page names can be topics, posts, feeds, favors, following
    # XXX feeds, favors and following not implemented
    $scope.goto = (page) ->
      ProfileActivePage.setActivePage(page)
      path = "profile/" + $scope.profileId + "/" + page
      $location.path path
]
