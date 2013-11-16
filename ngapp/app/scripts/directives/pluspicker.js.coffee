app = angular.module("topicaApp")
app.directive('pluspickerToggle', [
  '$document',
  ($document) ->
    openElement = null
    closeMenu = angular.noop
    {
      restrict: 'CA'
      link: (scope, element, attrs) ->
        scope.$watch('$location.path', ->
          console.log('init')
          closeMenu()
        )
        element.parent().bind('click', ->
          console.log("select")
          closeMenu()
        )
        element.bind('click', (event) ->
          console.log("open menu")
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
