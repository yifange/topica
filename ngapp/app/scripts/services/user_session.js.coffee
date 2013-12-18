###*
* @doc overview
* @id user_session_service
* @name topicaApp:UserSession
* @description This is the Usersession.
###

app = angular.module("topicaApp")
app.service "UserSession", [
  "$http",
  "Configs",
  "authService",
  "$cookies",
  "$location",
  ($http, Configs, authService, $cookies, $location) ->
    session = undefined
    @login = (email, password, rememberMe) ->
      $http.post(Configs.apiRoot + "/login", {
        email: email
        password: password
        remember: rememberMe
      })
    @setSession = (data) ->
      session = {}
      session.id = data.id
      session.username = data.username
      session.email = data.email
      console.log(session.id)
      $cookies.id = "" + session.id
      $cookies.username = session.username
      $cookies.email = session.email

    @destroySession = ->
      session = undefined
      delete $cookies.uid
      delete $cookies.email
      delete $cookies.username

    @getSession = ->
      if session?
        session
      else if $cookies.id?
        session = {}
        session.id = parseInt($cookies.id)
        session.username = $cookies.username
        session.email = $cookies.email
        session
      else
        @destroySession()
        $location.path("/login")
        undefined

    undefined

]
