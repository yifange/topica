app = angular.module 'topicaApp', [
  'ngRoute',
  'restangular',
  'http-auth-interceptor',
  'ui.bootstrap'
]
app.config ($routeProvider) ->
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
    })

app.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl("/api/v1")

app.constant "Configs", {
  apiRoot: "/api/v1"
}
app.factory "UserSession", [
  "$http",
  "Configs",
  "authService",
  ($http, Configs, authService) ->
    {
      login: (email, password) ->
        $http.post(Configs.apiRoot + "/login", {
          email: email,
          password: password
        })
      currentUser: ->
        $http.get(Configs.apiRoot + /)
    }
]
app.run ($rootScope, $location, $http, Configs, authService) ->
  $rootScope.userSession = {}

  $rootScope.logout = ->
    $http.get(Configs.apiRoot + "/logout")
    delete $rootScope.user
    $location.path("/login")

  $rootScope.$on "event:auth-loginRequired", ->
    $rootScope.userSession.from = $location.path()
    $location.path('/login')

  $rootScope.$on "event:auth-loginConfirmed", (event, data) ->
    $rootScope.userSession.user = data

    if ($rootScope.userSession.from != undefined)
      $location.path($rootScope.userSession.from)
      delete $rootScope.userSession.from
    else
      $location.path("/")
