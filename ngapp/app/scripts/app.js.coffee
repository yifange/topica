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

app.run ($rootScope, $location, $http, Configs, authService) ->
  $rootScope.userSession = {}

  $rootScope.logout = ->
    $http.get(Configs.apiRoot + "/logout")
    delete $rootScope.userSession.id
    delete $rootScope.userSession.username
    delete $rootScope.userSession.email
    $location.path("/login")

  $rootScope.$on "event:auth-loginRequired", ->
    $rootScope.userSession.from = $location.path()
    $location.path('/login')

  $rootScope.$on "event:auth-loginConfirmed", (event, data) ->
    console.log(data)
    $rootScope.userSession.id = data.id
    $rootScope.userSession.username = data.username
    $rootScope.userSession.email = data.email

    if ($rootScope.userSession.from != undefined)
      $location.path($rootScope.userSession.from)
      delete $rootScope.userSession.from
    else
      $location.path("/")
