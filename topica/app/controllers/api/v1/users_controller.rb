# User controller
# Basic GRUD implemented

class Api::V1::UsersController < Api::V1::ApplicationController

  # Query for all the users in descendent order
  def index
    render :json => User.all.order("created_at DESC")
  end

  # Query for one user by id

  def show
    render :json => User.find(params[:id])  
  end

  # Create a new user

  def create
    user = User.new(user_params)
    if user.save
      render :json => user, :status => :created
    else
      render :json => user.errors, :status => :unprocessable_entity
    end
  end

  # Update an existing user

  def update
    comemnt = user.find(params[:id])
    if user.update_attributes(user_params)
      render :json => true, :head => :no_content
    else
      render :json => user.errors, :status => :unprocessable_entity
    end
  end

  # Destroy one user by ID

  def destroy
    Commnet.find(params[:id]).destroy
    render :json => true, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def user_params
    params.require(:user).permit(:user_id, :content)
  end
end
