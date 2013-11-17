app = angular.module("topicaApp")
app.directive('pluspickerMenuItem', [
  ->
    {
      restrict: "CA"
      transclude: true
      template: "<a ng-transclude></a>"
      link: (scope, element, attrs) ->
        element.bind('click', (event) ->
          text = element.find("span").text()
          scope.$apply ->

          event.preventDefault()
          event.stopPropagation()
        )
    }
])
app.directive('pluspickerToggle', [
  '$document',
  ($document) ->
    openElement = null
    closeMenu = angular.noop
    {
      restrict: 'CA'
      link: (scope, element, attrs) ->
        scope.$watch('$location.path', ->
          closeMenu()
        )
        # element.parent().bind('click', (e) ->
        #   console.log("select")
        #   event.preventDefault()
        #   event.stopPropagation()
        #   # closeMenu()
        # )
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
# app.directive("pluspicker-close", [
#   ->
#     {
#       restrict: "CA"
#
#     }
# )
app.directive("pluspickerListitem", [
  ->
    {
      restrict: "CA"
      transclude: true
      template: "<span class='pluspicker-listitem-content'><span class='pluspicker-listitem-text' ng-transclude></span><div class='pluspicker-close'><i class='fa fa-times-circle'></i></div></span>"
      link: (scope, element, attrs) ->
        # console.log(scope)
        # console.log(element)
        # console.log(attrs)
    }

])
