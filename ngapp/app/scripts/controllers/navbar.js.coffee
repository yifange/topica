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
    openFullMenu = false
    selectedMenuItem = ""

    $scope.arrowClass = (name) ->
      if selectedMenuItem == name
        "fa-angle-double-left"
      else
        "fa-angle-double-right"

    $scope.selectMenuItem = (name) ->
      if selectedMenuItem == ""
        selectedMenuItem = name
      else
        selectedMenuItem = ""

    $scope.toggleHotcornerMenu = ->
      openFullMenu = !openFullMenu

    $scope.showMenuItem = (name) ->
      (selectedMenuItem == "") or (selectedMenuItem == name)

    $scope.hotcornerIconClass = ->
      if $scope.hoverHotcornerMenu or openFullMenu
        "hotcorner-selected"
      else
        ""
    $scope.hotcornerMenuClass = ->
      if openFullMenu
        "hotcorner-open-all"
      else
        if $scope.hoverHotcornerMenu
          "hotcorner-open-all"
        else if $scope.hoverHotcornerIcon
          "hotcorner-open-part"
        else
          ""
  ]
