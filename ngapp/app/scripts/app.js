'use strict';

var app = angular.module('topicaApp', ['ngRoute', 'restangular', 'http-auth-interceptor'])
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
