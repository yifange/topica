class Api::V1::HomeController < Api::V1::ApplicationController
  def index
    topics = User.find(current_user.id).following_topics.includes :user, :posts => :comments
    render :json => topics, :include => {:user => {}, :posts => {:methods => :comment_size}}
  end
end
