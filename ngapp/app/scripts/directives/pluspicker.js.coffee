app = angular.module("topicaApp.directive", [])
app.directive 'pluspicker', ['$document'
  ($document) ->
    openElement = null
    closeMenu = angular.noop
    {
      restrict: "CA"
      scope: {
        items: "="
      }
      template: """
      <div class='pluspicker-toggle pluspicker-box'>
        <span class='pluspicker-listitem' ng-repeat='item in items | filter: {selected: true}'>
          <span class='pluspicker-listitem-content'>
            <span class='pluspicker-listitem-text'>
              {{item.text}}
            </span>
            <div class='pluspicker-close' ng-click='toggleSelection({{item.id}}, $event)'>
              <i class='fa fa-times-circle'></i>
            </div>
          </span>
        </span>
        <span class='pluspicker-input-area'>
          <input type='text' class='pluspicker-input-area' placeholder='+ add topic' ng-model="input">
          </input>
        </span>
      </div>
      <ul class='pluspicker-menu'>
        <li class='pluspicker-menu-item' ng-repeat='item in items | filter: {selected: false} | filter: input' ng-click='toggleSelection({{item.id}}, $event)'>
          <a>
            {{item.text}}
          </a>
        </li>
      </ul>
              """
      link: (scope, element, attrs) ->

        scope.toggleSelection = (id, $event) ->
          for item in scope.items
            if item.id == id
              if item.selected == false
                scope.input = ''
              item.selected = !item.selected
              break
          $event.stopPropagation()

        scope.$watch('$location.path', ->
          closeMenu()
        )
        element.bind 'click', (event) ->
          elementWasOpen = (element == openElement)
          event.preventDefault()
          event.stopPropagation()
          if (!!openElement)
            closeMenu()
          if (!elementWasOpen)
            element.addClass('open')
            openElement = element
            closeMenu = (event) ->
              if (event)
                event.preventDefault()
                event.stopPropagation()
              $document.unbind('click', closeMenu)
              element.removeClass('open')
              closeMenu = angular.noop
              openElement = null
            $document.bind('click', closeMenu)
    }
]
