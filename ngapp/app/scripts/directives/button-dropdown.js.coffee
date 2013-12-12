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
        feeds: "="
        selected: "="
        following: "="
        user: "&"
        followshipId: "="
        topicId: "&"
      }
      templateUrl: "views/button_dropdown.html"
      link: (scope, element, attrs) ->
        scope.isMenuOpen = false
        scope.isEditing = false

        element.bind "click", (event) ->
          event.preventDefault()
          event.stopPropagation()

        showOnTop = (element) ->
          if ($position.offset(element).top - $window.scrollY) <= ($window.innerHeight - 40) / 2
            false
          else
            true
        scope.createFeed = ->
          if scope.newFeed
            Restangular.one("users", scope.user().id).all("feeds").post({
              name: scope.newFeed
            }).then (feed) ->
              scope.feeds.push {id: feed.id, name: feed.name, number: 0}
              scope.newFeed = ""
              scope.isEditing = false

        scope.selectId = (feedId, $event) ->
          $event.preventDefault()
          $event.stopPropagation()
          if scope.following is false
            # create followship, set selection, set followship id
            scope.selected = {id: feedId, name: _.find(scope.feeds, {id: feedId}).name}
            (_.find scope.feeds, {id: feedId}).number += 1

            Restangular.one("users", scope.user().id).all("followships").post(
              {
                topic_id: scope.topicId()
                feed_id: feedId
              }
            ).then (followship) ->
              scope.followshipId = followship.id
            scope.following = true

          else
            if !scope.selected or scope.selected.id isnt feedId
              # Update followship, set selection
              Restangular.one("users", scope.user().id).one("followships", scope.followshipId).put(
                {
                  feed_id: feedId
                }
              )

              (_.find scope.feeds, {id: scope.selected.id}).number -= 1
              (_.find scope.feeds, {id: feedId}).number += 1

              scope.selected = {id: feedId, name: _.find(scope.feeds, {id: feedId}).name}
            else if scope.selected.id is feedId
              # Destroy followship, unset followship id
              Restangular.one("users", scope.user().id).one("followships", scope.followshipId).remove()
              (_.find scope.feeds, {id: feedId}).number -= 1
              scope.following = false
              scope.selected = {}



        scope.openInput = ($event) ->
          $event.preventDefault()
          $event.stopPropagation()
          scope.isEditing = true

        scope.openMenu = ->
          scope.isMenuOpen = true
          scope.showOnTop = showOnTop(element)
          scope.isEditing = false


        scope.closeMenu = ->
          unless scope.isEditing
            scope.isMenuOpen = false


        $document.bind "click", (event) ->
          scope.$apply("isMenuOpen = false")

    }
]
