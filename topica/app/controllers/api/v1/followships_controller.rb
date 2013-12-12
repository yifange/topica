# Followship controller
#
# The followship relationship of the users and the topics
# Author:: Yifan Ge
class Api::V1::FollowshipsController < Api::V1::ApplicationController

  # Follow a topic
  # GET     /api/v1/users/:user_id/followships/:topic_id 
  # POST    /api/v1/users/:user_id/followships
  def create
    followship = Followship.new(:user_id => current_user.id, :topic_id => params[:topic_id], :feed_id => params[:feed_id])
    if followship.save
      render :json => followship, :status => :created
    else
      render :json => {:ok => false, :message => followship.errors}, :status => :unprocessable_entity
    end
  end
 
  # Change following feed
  #
  # PUT     /api/v1/users/:user_id/followship/:followship_id
  #
  def update
    followship = Followship.find(params[:followship_id])
    if followship.update_attribute(:feed_id, params[:feed_id])
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => followship.errors}, :status => :unprocessable_entity
    end
  end
  # Un-follow a topic
  #
  # DELETE  /api/v1/users/:user_id/followships/:topic_id
  def destroy
    followship = Followship.find(params[:followship_id])
    followship.destroy
    render :json => {:ok => true}, :head => :no_content
  end


end
