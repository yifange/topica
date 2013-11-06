class Api::V1::HomeController < Api::V1::ApplicationController
  def index
    render :text => "current user is #{current_user.id}: #{current_user.email}"
    # redirect_to api_v1_user_posts_path(:user_id => current_user.id)
  end
end
