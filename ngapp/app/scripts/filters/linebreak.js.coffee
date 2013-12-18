###*
* @ngdoc filter
* @id linkbreak_filter
* @name topicaApp.filters:LinebreakFilters
* @description This is the LinebreakFilters.
*
###

# http://stackoverflow.com/a/13979292
app = angular.module("topicaApp.filters.linebreak", [])
app.filter "linebreak", ->
  (text) ->
    text.replace(/\n/g, '<br/>')
