app = angular.module("topicaApp.directives.newscard", [])
app.directive "newscard", ["$http", "Restangular",
  ($http, Restangular) ->
    {
      restrict: "CA"
      scope: {
        posts: "="
        user: "="
        topics: "="
      }
      templateUrl: "views/newscard.html"
      link: (scope, element, attrs) ->

        scope.newComment = []
        commentOpenStates = []
        newCommentOpenStates = []
        repostCommentOpenStates = []

        scope.toggleComments = (index) ->
          commentOpenStates[index] = !commentOpenStates[index]
          if commentOpenStates[index]
            Restangular.one("posts", scope.posts[index].id).getList("comments").then (comments) ->
              scope.posts[index].comments = comments
              scope.posts[index].comment_size = comments.length if scope.posts[index].comment_size != comments.length

        scope.commentIsOpen = (index) ->
          !!commentOpenStates[index]

        scope.openNewComment = (index) ->
          newCommentOpenStates[index] = true
          repostCommentOpenStates[index] = false

        scope.closeNewComment = (index) ->
          newCommentOpenStates[index] = false
          scope.posts[index].newComment = ""

        scope.openRepostComment = (index) ->
          repostCommentOpenStates[index] = true
          newCommentOpenStates[index] = false

        scope.closeRepostComment = (index) ->
          repostCommentOpenStates[index] = false
          scope.posts[index].newComment = ""

        scope.newCommentIsOpen = (index) ->
          !!newCommentOpenStates[index]

        scope.repostCommentIsOpen = (index) ->
          !!repostCommentOpenStates[index]

        scope.submitComment = (index) ->
          Restangular.one("posts", scope.posts[index].id).all("comments").post({
            content: scope.posts[index].newComment,
          }).then (comment) ->
            scope.posts[index].newComment = ""
            comment.user = scope.user
            if !scope.posts[index].comments
              scope.posts[index].comments = []
            scope.posts[index].comments.push comment
            scope.posts[index].comment_size += 1

        scope.commentLoseFocus = ->
          scope.focusComment = false

        scope.reposeCommentLoseFocus = ->
          scope.focusRepostComment = false
    }
]
