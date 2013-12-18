app = angular.module("topicaApp")

###*
* @doc overview
* @id navbar_controller
* @name topicaApp.controllers:NavbarController
* @description This is the Navbarcontroller
*
###

app.controller 'NavbarController', [
  # "Restangular",
  "$rootScope",
  "UserSession",
  "$scope",
  ($rootScope, UserSession, $scope) ->
    $scope.user = UserSession.getSession()
    openHotcornerMenu = false
    openFullMenu = false
    selected = false
    menuItems = [
      {
        name: "user"
        text: "Users"
        icon: "user"
      },
      {
        name: "feed"
        text: "Feeds"
        icon: "folder"
      },
      {
        name: "topic"
        text: "Topics"
        icon: "comment-o"
      }
    ]
    $scope.visibleItems = menuItems

    $scope.arrowClass = (name) ->
      if selected
        "fa-angle-double-left"
      else
        "fa-angle-double-right"

    $scope.selectMenuItem = (index) ->
      if !selected
        $scope.visibleItems = [$scope.visibleItems[index]]
        selected = true
      else
        $scope.visibleItems = menuItems
        selected = false

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

