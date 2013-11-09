app = angular.module("topicaApp")
app.controller 'MainController', ["Restangular", "$scope", "$http", "Configs", "$location", "$rootScope", (Restangular, $scope, $http, Configs, $location, $rootScope) ->
  Restangular.all("home").getList().then (posts) ->
    $scope.posts = posts
]
