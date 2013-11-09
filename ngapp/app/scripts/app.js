'use strict';

var app = angular.module('topicaApp', ['ngRoute', 'restangular', 'http-auth-interceptor', 'ui.bootstrap'])
app.config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainController'
      })
      .when('/login', {
        templateUrl: 'views/login.html',
        controller: 'LoginController'
      })
      .otherwise({
        redirectTo: '/'
      });
  });

app.config(function(RestangularProvider) {
  RestangularProvider.setBaseUrl("/api/v1");
});
app.constant("Configs", {
  apiRoot: "/api/v1"
});
app.run(function($rootScope, $location, $http, Configs, authService) {
  $rootScope.userSession = {};
  $rootScope.logout = function() {
    $http.get(Configs.apiRoot + "/logout");
    delete $rootScope.userSession.id;
    delete $rootScope.userSession.username;
    delete $rootScope.userSession.email;
    $location.path("/login");
  };
  $rootScope.$on("event:auth-loginRequired", function() {
    $rootScope.userSession.from = $location.path();
    $location.path('/login');
  });
  $rootScope.$on("event:auth-loginConfirmed", function(event, data) {
    console.log(data);
    $rootScope.userSession.id = data.id;
    $rootScope.userSession.username = data.username;
    $rootScope.userSession.email = data.email;

    if ($rootScope.userSession.from != undefined) {
      $location.path($rootScope.userSession.from);
      delete $rootScope.userSession.from;
    } else {
      $location.path("/");
    }
  });
});
