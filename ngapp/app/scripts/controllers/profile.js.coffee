app = angular.module("topicaApp")
app.controller "ProfileController", [
  "Restangular",
  "$scope",
  "$location",
  "UserSession",
  (Restangular, $scope, $location, UserSession) ->
    $scope.user = UserSession.getSession()
]
