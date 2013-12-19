###*
 * @doc module
 * @name topicaApp
 * @description The main module of the project.
 *
 * All the dependencies for the topica module and all the routing rules are defined here.
 *
 ###
app = angular.module 'topicaApp', [
  'ngRoute',
  'ngSanitize',
  'ngCookies',
  'restangular',
  'http-auth-interceptor',
  'ui.bootstrap',
  'ngAnimate',
  'monospaced.elastic',
  "angularMoment",
  "ui-gravatar",
  "md5",
  "topicaApp.directives.pluspicker",
  "topicaApp.directives.ngFocus",
  "topicaApp.directives.newscard",
  "topicaApp.filters.linebreak",
  "topicaApp.directives.buttonDropdown"
]
app.config ["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainController'
    })
    .when('/login', {
      templateUrl: 'views/login.html',
      controller: 'LoginController'
    })
    .when('/signup', {
      templateUrl: 'views/signup.html',
      controller: 'SignupController'
    })
    .when('/profile/:profileId', {
      templateUrl: 'views/profile_topics.html',
      controller: 'ProfileTopicsController'
    })
    .when('/profile/:profileId/topics/:topicId', {
      templateUrl: 'views/profile_topics.html',
      controller: 'ProfileTopicsController'
    })
    .when('/profile/:profileId/topics', {
      templateUrl: 'views/profile_topics.html',
      controller: 'ProfileTopicsController'
    })
    .when('/profile/:profileId/posts', {
      templateUrl: 'views/profile_posts.html'
      controller: 'ProfilePostsController'
    })
    .when('/profile/:profileId/feeds', {
      templateUrl: 'views/profile_feeds.html'
      controller: 'ProfileFeedsController'
    })
    .otherwise({
      redirectTo: '/'
    })
]

app.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl("/api/v1")

app.constant "Configs", {
  apiRoot: "/api/v1"
}


app.run ($rootScope, $location, $http, Configs, authService, UserSession) ->
  $rootScope.changeView = (view) ->
    $location.path(view)
  $rootScope.logout = ->
    $http.get(Configs.apiRoot + "/logout")
    UserSession.destroySession()
    $location.path("/login")

  $rootScope.$on "event:auth-loginRequired", ->
    $location.path('/login')

  $rootScope.$on "event:auth-loginConfirmed", (event, data) ->
    UserSession.setSession(data)
    #XXX Redirect back?
    $location.path("/")
