app = angular.module("topicaApp")
app.service "ProfileActivePage", ->
  activePage = ""
  @setActivePage = (page) ->
    activePage = page
  @getActivePage = ->
    activePage
  null
