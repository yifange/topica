###*
* @doc overview
* @id profile_active_page_service
* @name topicaApp:ProfileActivePage
* @description This is the profileactivepage.
*
###
#
app = angular.module("topicaApp")
app.service "ProfileActivePage", ->
  activePage = ""
  @setActivePage = (page) ->
    activePage = page
  @getActivePage = ->
    activePage
  null
