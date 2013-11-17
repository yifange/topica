app = angular.module('topicaApp')
app.filter('selected', ->
  return (input) ->
    out = []
    for i = 0; i < input.length; i++
      if (input[i].selected)
        out.push input[i]
    out
)
app.filter('unselected', ->
  return (input) ->
    out = []
    for i = 0; i < input.length; i++
      if (!input[i].selected)
        out.push input[i]
    out
)
