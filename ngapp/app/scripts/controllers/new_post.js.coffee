app = angular.module("topicaApp")
app.controller "NewPostController", [
  "$scope",
  ($scope) ->
    console.log("hello")
    $scope.showSelectedTopics = ->
      console.log($scope.topics)
    $scope.topics = [
      {id: 0, text: "Sports", selected: false}
      {id: 1, text: "Movies", selected: false}
      {id: 2, text: "Games", selected: false}
    ]
]
