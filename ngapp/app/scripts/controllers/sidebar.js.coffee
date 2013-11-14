app = angular.module("topicaApp")
app.controller "SidebarController", [
  '$scope',
  ($scope) ->
    $scope.hello = ->
      console.log("hello")
    isMenuOpen = false

    $scope.mouseOverIconMenu = false
    $scope.mouseOverMenu = false

    # $scope.bodyClickFn = () ->
    #   closeMenu()

    $scope.mouseEnterIconMenu = ->
      console.log("mouseEnterIconMenu")
      $scope.mouseOverIconMenu = true
    $scope.mouseLeaveIconMenu = ->
      console.log("mouseLeaveIconMenu")
      $scope.mouseOverIconMenu = false

    $scope.mouseEnterMenu = ->
      $scope.mouseOverMenu = true
    $scope.mouseLeaveMenu = ->
      $scope.mouseOverMenu = false


    # $scope.openIconMenu = () ->
    #   classie.add( menu, 'gn-open-part' )
    # $scope.closeIconMenu = () ->
    #   classie.remove( menu, 'gn-open-part' )
    # $scope.openMenu = () ->
    #   if( !isMenuOpen )
    #     # classie.add( trigger, 'gn-selected' )
    #     isMenuOpen = true
    #     # classie.add( menu, 'gn-open-all' )
    #     $scope.closeIconMenu()
    # $scope.closeMenu = () ->
    #   if( isMenuOpen )
    #     # classie.remove( trigger, 'gn-selected' )
    #     isMenuOpen = false
    #     # classie.remove( menu, 'gn-open-all' )
    #     $scope.closeIconMenu()
]
