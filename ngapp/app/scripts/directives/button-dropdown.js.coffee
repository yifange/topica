app = angular.module("topicaApp.directives.buttonDropdown", ['ui.bootstrap.position'])
app.directive 'buttonDropdown', [
  '$document',
  '$http',
  '$position',
  '$window',
  'Restangular',
  ($document, $http, $position, $window, Restangular) ->
    {
      restrict: "CA"
      scope: {
        items: "="
        selected: "="
        following: "="
        rel: "&"
      }
      templateUrl: "views/button_dropdown.html"
      link: (scope, element, attrs) ->
        showOnTop = (element) ->
          if ($position.offset(element).top - $window.scrollY) <= ($window.innerHeight - 40) / 2
            false
          else
            true

        scope.selectId = (feedId, $event) ->
          $event.preventDefault()
          $event.stopPropagation()
          if scope.following is false
            # create followship, set selection, set followship id
            scope.following = true

          else
            if !scope.selected or scope.selected.id isnt feedId
              # Update followship, set selection
              scope.selected = {id: feedId, name: _.find(scope.items, {id: feedId}).name}
            else if scope.selected.id is feedId
              # Destroy followship, unset followship id
              scope.following = false
              scope.selected = {}



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

    }
]
