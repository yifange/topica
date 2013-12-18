###*
# @doc overview
* @ngdoc directive
* @id newscard
* @name topicaApp.directive.newscard:NewscardDirective
* @description newscard directive
*
* Used to show all the posts
###
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
          unless commentOpenStates[index]
            if scope.posts[index].comments
              commentOpenStates[index] = true
            Restangular.one("posts", scope.posts[index].id).getList("comments").then (comments) ->
              if (_.size(scope.posts[index].comments) isnt scope.posts[index].comment_size) or (!scope.posts[index].comments) or (_.max(scope.posts[index].comments, "updated_at") < _.max(comments, "updated_at"))
                scope.posts[index].comments = comments
                scope.posts[index].comment_size = comments.length
                commentOpenStates[index] = true
          else
            commentOpenStates[index] = false

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

        scope.repost = (index) ->
          scope.submitComment(index)
          scope.selectedTopicIds = _.map _.filter(scope.topics, 'selected'), (topic) -> topic.id
          topics = _.map _.filter(scope.topics, 'selected'), (topic) ->
              {
                id: topic.id
                name: topic.text
                topic_type: topic.topic_type
              }

          Restangular.all("posts").post({
            title: scope.posts[index].title
            content: scope.posts[index].content
            topic_ids: scope.selectedTopicIds
          }).then (response) ->
            newPost = response
            newPost.user = scope.user
            newPost.num_of_comments = 0
            newPost.topics = topics
            console.log scope.selectedTopicIds
            main_scope = angular.element(document.getElementById("main-view")).scope()
            main_scope.posts.unshift(newPost)
            for topic in scope.topics
              topic.selected = false
            newPost = null
            console.log scope.topics
            console.log scope.topics
            scope.closeRepostComment(index)



        scope.commentLoseFocus = ->
          scope.focusComment = false

        scope.repostCommentLoseFocus = ->
          scope.focusRepostComment = false
    }
]
