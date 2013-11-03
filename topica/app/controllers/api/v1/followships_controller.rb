# Followship controller
#
# The followship relationship of the users and the topics
# Author:: Yifan Ge
class Api::V1::FollowshipsController < ApplicationController

  # Follow a topic
  # GET     /api/v1/users/:user_id/followships/:topic_id 
  # POST    /api/v1/users/:user_id/followships
  def create
    followship = Followship.new(:user_id => params[:user_id], :topic_id => params[:topic_id])
    if followship.save
      render :json => followship, :status => :created
    else
      render :json => {:ok => false, :message => followship.errors}, :status => :unprocessable_entity
    end
  end
  
  # Un-follow a topic
  #
  # DELETE  /api/v1/users/:user_id/followships/:topic_id
  def destroy
    followship = Followship.where(:user_id => params[:user_id], :topic_id => params[:topic_id]) 
    followship.destroy
    render :json => {:ok => true}, :head => :no_content
  end


end
