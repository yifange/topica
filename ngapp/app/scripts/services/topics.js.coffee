###*
* @doc overview
* @id topics_service
* @name topicaApp:Topics
* @description Used to share topics among old repost inputs in homepage and the profile page.
*
*
###

app = angular.module("topicaApp")
app.service "Topics", [
  "$http",
  "UserSession",
  "Restangular",
  ($http, UserSession, Restangular) ->
    topics = null
    @fetchTopics = ->
      user = UserSession.getSession()
      Restangular.one("users", user.id).all("topics").getList().then (data) ->
        topics = ({id: item.id, text: item.name, selected: false} for item in data)
    @getTopics = ->
      if not topics
        @fetchTopics()
      topics
]
