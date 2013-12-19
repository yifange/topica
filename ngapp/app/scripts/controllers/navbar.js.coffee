###*
* @doc overview
* @id navbar_controller
* @name topicaApp.controllers:NavbarController
* @description Navbar controller
*
* Provides the functionalities for both the: top navbar and the side bar partials.
* The controller mainly maintains the opening states of the side bar, which can be closed, fully opened, and partly opened (When hovering on the hot corner icon).
* Currently the controller holds four items: Search, User, Feed, and Topic.
###

app = angular.module("topicaApp")

app.controller 'NavbarController', [
  "$rootScope",
  "UserSession",
  "$scope",
  ($rootScope, UserSession, $scope) ->
    $scope.user = UserSession.getSession()
    openHotcornerMenu = false
    openFullMenu = false
    selected = false

    # The items in the sidebar
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
    # The currently displaying item
    $scope.visibleItems = menuItems

    $scope.arrowClass = (name) ->
      if selected
        "fa-angle-double-left"
      else
        "fa-angle-double-right"
    # Select an item from the sidebar. Set the visibleItems and toggle the selected flag
    $scope.selectMenuItem = (index) ->
      if !selected
        $scope.visibleItems = [$scope.visibleItems[index]]
        selected = true
      else
        $scope.visibleItems = menuItems
        selected = false

    # Toggle the full hotcorner menu when clicking on the hotcorner icon
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

