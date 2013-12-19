###*
* @doc overview
* @id profile_active_page_service
* @name topicaApp:ProfileActivePage
* @description Hosts the active profile subpage. The page can be topics, feeds, posts, following or favors.
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
