app = angular.module("topicaApp.directives.buttonDropdown", [])
app.directive 'buttonDropdown', ['$document', '$http', ($document, $http) ->
  {
    restrict: "CA"
    scope: {
      # items: "="
      remoteUrl: "@"
    }
    templateUrl: "views/button_dropdown.html"
    link: (scope, element, attrs) ->

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
