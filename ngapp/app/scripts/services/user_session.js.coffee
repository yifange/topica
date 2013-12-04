app = angular.module("topicaApp")
app.service "UserSession", [
  "$http",
  "Configs",
  "authService",
  "$cookies",
  ($http, Configs, authService, $cookies) ->
    session = {}
    @login = (email, password, rememberMe) ->
      $http.post(Configs.apiRoot + "/login", {
        email: email
        password: password
        remember: rememberMe
      })
    @currentUser = ->
      $http.get(Configs.apiRoot + "/me")
]
