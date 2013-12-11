app = angular.module("topicaApp.directives.buttonDropdown", ['ui.bootstrap.position'])
app.directive 'buttonDropdown', [
  '$document',
  '$http',
  '$position',
  '$window',
  ($document, $http, $position, $window) ->
    {
      restrict: "CA"
      scope: {
        # items: "="
        remoteUrl: "@"
      }
      templateUrl: "views/button_dropdown.html"
      link: (scope, element, attrs) ->
        scope.openMenu = ->
          scope.isMenuOpen = true

          if ($position.offset(element).top - $window.scrollY) <= ($window.innerHeight - 40) / 2
            scope.showOnTop = false
          else
            scope.showOnTop = true

        scope.closeMenu = ->
          scope.isMenuOpen = false

        scope.items = [
          {
            name: "Sports!!!!!!!"
            selected: false
          },
          {
            name: "Music"
            selected: true
          },
          {
            name: "Fun"
            selected: false
          },
          {
            name: "Travel"
            selected: false
          }
          {
            name: "Travel"
            selected: false
          }
          {
            name: "Travel"
            selected: false
          }
          {
            name: "Travel"
            selected: false
          }
          {
            name: "Travel"
            selected: false
          }
          {
            name: "Travel"
            selected: false
          }
        ]
    }
]
