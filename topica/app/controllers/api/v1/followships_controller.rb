class Api::V1::FollowshipsController < ApplicationController
  def create
    followship = Followship.new(:user_id => params[:user_id], :topic_id => params[:topic_id])
    if followship.save
      render :json => followship, :status => :created
    else
      render :json => {:ok => false, :message => followship.errors}, :status => :unprocessable_entity
    end
  end

  def destroy
    followship = Followship.where(:user_id => params[:user_id], :topic_id => params[:topic_id]) 
    followship.destroy
    render :json => {:ok => true}, :head => :no_content
  end

  def all_following_topics
    topics = User.find(:id => params[:user_id]).following_topics
    render :json => topics
  end

  def all_following_users
    users = Topic.find(:id => params[:topic_id]).following_users
    render :json => users
  end
end
