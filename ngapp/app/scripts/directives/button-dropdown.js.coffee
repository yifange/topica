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

        showOnTop = (element) ->
          if ($position.offset(element).top - $window.scrollY) <= ($window.innerHeight - 40) / 2
            false
          else
            true

        scope.openInput = ($event) ->
          $event.preventDefault()
          $event.stopPropagation()
          scope.isEditing = true

        scope.openMenu = ->
          scope.isMenuOpen = true
          scope.showOnTop = showOnTop(element)


        scope.closeMenu = ->
          unless scope.isEditing
            scope.isMenuOpen = false


        $document.bind "click", (event) ->
          scope.$apply("isEditing = false")
          scope.$apply("isMenuOpen = false")

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
