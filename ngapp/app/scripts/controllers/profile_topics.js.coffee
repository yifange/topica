app = angular.module('topicaApp')
app.controller "ProfileTopicsController", [
  "Restangular",
  "UserSession",
  "$scope",
  (Restangular, UserSession, $scope) ->
    $scope.user = UserSession.getSession()
    Restangular.one("users", $scope.user.id).all("detailed_topics").getList().then (topics) ->
      $scope.topics = topics

]
