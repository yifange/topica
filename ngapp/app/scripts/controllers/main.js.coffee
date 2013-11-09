app = angular.module("topicaApp")
app.controller 'MainController', ["Restangular", "$scope", "$http", "Configs", "$location", "$rootScope", (Restangular, $scope, $http, Configs, $location, $rootScope) ->
  Restangular.all("home").getList().then (posts) ->
    $scope.user = {}
    $scope.user.username = $rootScope.userSession.username
    $scope.user.email = $rootScope.userSession.email
    $scope.user.id = $rootScope.userSession.id
    $scope.posts = posts
]
