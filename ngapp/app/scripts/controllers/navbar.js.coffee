app = angular.module("topicaApp")
app.controller 'NavbarController', [
  # "Restangular",
  "$rootScope",
  "UserSession",
  ($rootScope, UserSession) ->
    UserSession.currentUser().then (response) ->
      $rootScope.userSession.user = response.data
    , (error) ->
      $rootScope.userSession.user = {"username": "user"}
  ]
