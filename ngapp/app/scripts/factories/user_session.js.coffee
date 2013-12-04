app = angular.module("topicaApp")
app.factory "UserSession", [
  "$http",
  "Configs",
  "authService",
  "$cookies",
  ($http, Configs, authService, $cookies) ->
    {
      login: (email, password, rememberMe) ->
        $http.post(Configs.apiRoot + "/login", {
          email: email,
          password: password
          remember: rememberMe
        })
      currentUser: ->
        $http.get(Configs.apiRoot + "/me")
    }
]
