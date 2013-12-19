###*
* @ngdoc filter
* @id linkbreak_filter
* @name topicaApp.filters:LinebreakFilters
* @description This is the LinebreakFilters.
* Used to parse all the linebreaks (\n) in posts and comments to html new lines (<br/>).
* Otherwise, the linebreaks will not show in the web pages.
*
###

# http://stackoverflow.com/a/13979292
app = angular.module("topicaApp.filters.linebreak", [])
app.filter "linebreak", ->
  (text) ->
    text.replace(/\n/g, '<br/>')
