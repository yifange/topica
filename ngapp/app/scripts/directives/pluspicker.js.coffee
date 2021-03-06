###*
* @ngdoc directive
* @id pluspicker
* @name topicaApp.directives.pluspicker:PluspickerDirectives
* @description Pluspicker directive
*
* Used to select target topics for a new post or repost.
* Multi-select the topics, filter the topics and add new topics.
*
###

app = angular.module("topicaApp.directives.pluspicker", [])
app.directive 'pluspicker', ['$document', '$http',
  ($document, $http) ->
    openElement = null
    closeMenu = angular.noop
    {
      restrict: "CA"
      scope: {
        items: "="
        addItem: "&onAdd"
        remoteUrl: "@"
        itemTemplate: "&"
      }
      template: """
      <div ng-class="{'open': isOpen}">
        <div class='pluspicker-toggle pluspicker-box' ng-click="openMenu($event)">
          <span class='pluspicker-listitem' ng-repeat='item in selectedItems'>
            <span class='pluspicker-listitem-content'>
              <span class='pluspicker-listitem-text'>
                {{item.text}}
              </span>
              <div class='pluspicker-close' ng-click='deselectItem(item.id, $event)'>
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
          <li class='pluspicker-menu-item' ng-repeat='item in items | filter: {selected: false} | filter: input' ng-click='selectItem(item.id, $event)'>
            <a>
              {{item.text}}
            </a>
          </li>
          <li class='pluspicker-menu-item pluspicker-menu-add' ng-click='newItem()' ng-show='!!input && isNew()'>
            <a>
              Add "{{input}}"
            </a>
          </li>
        </ul>
      </div>
              """
      link: (scope, element, attrs) ->
        scope.selectedItems = []

        scope.isNew = ->
          !(_.contains(_.map(scope.items, (item) -> item.text), scope.input))

        scope.newItem = ->
          data = scope.itemTemplate()
          data.name = scope.input
          $http.post(scope.remoteUrl, data).then (response) ->
            newItem = {id: response.data.id, text: data.name, selected: true}
            scope.selectedItems.push newItem
            scope.items.unshift newItem

          scope.input = ""
          scope.addItem({item: scope.input})

        scope.selectItem = (id, $event) ->
          item = (_.find scope.items, (item) ->
            item.id == id
          )
          item.selected = true
          scope.selectedItems.push item
          $event.preventDefault()
          $event.stopPropagation()

        scope.deselectItem = (id, $event) ->
          (_.find scope.items, (item) ->
            item.id == id
          ).selected = false

          # XXX Should change to _.remove when restangular gets updated
          # XXX because the current restangular version depends on lodash 1.3

          scope.selectedItems = scope.selectedItems.filter (item) ->
            item.id isnt id
          $event.preventDefault()
          $event.stopPropagation()

        $document.bind "click", (event) ->
          scope.$apply("isOpen = false")
          scope.$apply("input = ''")

        scope.openMenu = ($event) ->
          $event.preventDefault()
          $event.stopPropagation()
          scope.isOpen = true

        scope.$watch('$location.path', ->
          scope.isOpen = false
          scope.input = ""
        )
    }
]
