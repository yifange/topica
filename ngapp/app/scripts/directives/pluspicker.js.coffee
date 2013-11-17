app = angular.module("topicaApp")
app.directive 'pluspickerMenu', [
  ->
    {
      restrict: "CA"
      scope: {
        items: "="
      }
      template: """
        <li class='pluspicker-menu-item' ng-repeat='item in items | filter: {selected: false}' ng-click='toggleSelection({{item.id}}, $event)'>
          <a>
            {{item.text}}
          </a>
        </li>
                """
      link: (scope, element, attrs) ->
        scope.toggleSelection = (id, $event) ->
          for item in scope.items
            if item.id == id
              item.selected = !item.selected
          $event.stopPropagation()
    }
]
app.directive('pluspickerToggle', [
  '$document',
  ($document) ->
    openElement = null
    closeMenu = angular.noop
    {
      restrict: 'CA'
      scope: {
        items: "="
      }
      template: """
        <span class='pluspicker-listitem' ng-repeat='item in items | filter: {selected: true}'><span class='pluspicker-listitem-content'><span class='pluspicker-listitem-text'>{{item.text}}</span><div class='pluspicker-close' ng-click='toggleSelection({{item.id}}, $event)'><i class='fa fa-times-circle'></i></div></span></span>
                """
      link: (scope, element, attrs) ->
        scope.toggleSelection = (id, $event) ->
          for item in scope.items
            if item.id == id
              item.selected = !item.selected
          $event.stopPropagation()
        scope.$watch('$location.path', ->
          closeMenu()
        )
        element.bind('click', (event) ->
          elementWasOpen = (element == openElement)

          event.preventDefault()
          event.stopPropagation()

          if (!!openElement)
            closeMenu()

          if (!elementWasOpen)
            element.parent().addClass('open')
            openElement = element
            closeMenu = (event) ->
              if (event)
                event.preventDefault()
                event.stopPropagation()
              $document.unbind('click', closeMenu)
              element.parent().removeClass('open')
              closeMneu = angular.noop
              openElement = null
            $document.bind('click', closeMenu)
        )
    }
])
