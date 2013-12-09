class Api::V1::HomeController < Api::V1::ApplicationController
  def index

    posts = User.find(current_user.id).following_posts.includes(:comments, :topics => :user).uniq.order(:updated_at => :desc).map do |post|
      {
        :id => post.id, 
        :content => post.content, 
        :title => post.title, 
        :created_at => post.created_at,
        :updated_at => post.updated_at,
        :topics => post.topics,
        :user => post.user,
        :comment_size => post.comments.size
      }
    end
    render :json => posts
  end
end
