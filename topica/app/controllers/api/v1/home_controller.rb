class Api::V1::HomeController < Api::V1::ApplicationController
  def index
    # posts = User.find(current_user.id).posts.order(:created_at => :desc).includes(:user, :comments)
    # posts.each do |post|
    #   post.num_of_comments = post.get_num_of_comments
    # end
    # render :json => posts, :include => {:user => {:only => [:email, :id, :username]}}
    topics = User.find(current_user.id).following_topics.includes({:user, :posts => {:comments}})
    render :json => topics, :include => {:user => {:only => [:email, :id, :username]}, :posts => {}}
  end
end
