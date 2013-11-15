app = angular.module("topicaApp")
app.controller 'NavbarController', [
  # "Restangular",
  "$rootScope",
  "UserSession",
  "$scope",
  ($rootScope, UserSession, $scope) ->
    UserSession.currentUser().then (response) ->
      $rootScope.userSession.user = response.data
    , (error) ->
      $rootScope.userSession.user = {"username": "user"}



    openHotcornerMenu = false
    $scope.toggleHotcornerMenu = ->
      openHotcornerMenu = !openHotcornerMenu
    $scope.hotcornerIconClass = ->
      if $scope.hoverHotcornerMenu
        "hotcorner-selected"
      else
        ""
    $scope.hotcornerMenuClass = ->
      if openHotcornerMenu
        "hotcorner-open-all"
      else
        if $scope.hoverHotcornerMenu
          "hotcorner-open-all"
        else if $scope.hoverHotcornerIcon
          "hotcorner-open-part"
        else
          ""
          # "hotcorner-open-all"
  ]
