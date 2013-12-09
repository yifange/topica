app = angular.module("topicaApp")
app.controller "ProfileAboutController", [
  "Restangular",
  "$scope",
  "$location",
  "UserSession",
  (Restangular, $scope, $location, UserSession) ->
    $scope.user = UserSession.getSession()
]
