# Favor controller.
# Used to manage the favor relatioship between a user and a post
#
# Author:: Yifan Ge

class Api::V1::FavorsController < Api::V1::ApplicationController
  # Favor a post 
  #
  # GET     /api/v1/users/:user_id/favors/:post_id
  # POST    /api/v1/users/:user_id/favors
  def create
    favor = Favor.new(:user_id => params[:user_id], :post_id => params[:post_id])
    if favor.save
      render :json => favor, :status => :created
    else
      render :json => {:ok => false, :message => favor.errors}, :status => :unprocessable_entity
    end
  end


  # Delete a favor relationship
  #
  # DELETE  /api/v1/users/:user_id/favors/:post_id
  def destroy
    favor = Favor.where(:user_id => params[:user_id], :post_id => params[:post_id])
    favor.destroy
    render :json => {:ok => true}, :head => :no_content
  end
end
