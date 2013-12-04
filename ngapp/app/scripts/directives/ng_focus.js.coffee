# http://stackoverflow.com/a/14859639
app = angular.module "topicaApp.directives.ngFocus", []
app.directive "ngFocus", ($timeout) ->
  return {
    link: (scope, element, attrs) ->
      scope.$watch(attrs.ngFocus, (val) ->
        if angular.isDefined(val) and val
          $timeout ->
            element[0].focus()
      , true)
      element.bind("blur", ->
        if (angular.isDefined(attrs.ngFocusLost))
          scope.$apply attrs.ngFocusLost
      )
  }
