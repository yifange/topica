# User controller
# Basic GRUD implemented

class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_filter :require_login, only: [:create]
  # wrap_parameters :user, :include => [:username, :email, :password, :password_confirmation]
  # Query for all the users in descendent order
  # GET /users
  def index
    render :json => User.all.order("created_at DESC")
  end

  # Query for one user by id
  # Params:
  # +id+:: user_id
  # GET /users/:user_id
  def show
    render :json => User.find(params[:id]).select(:id, :username, :email)
  end

  # Create a new user
  # Params:
  # +user+:: Hash of the user object to be created
  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      render :json => user, :status => :created
    else
      render :json => {:ok => false, :message => user.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing user
  # Params:
  # +id+:: user id
  # +user+:: Hash of the user object to be created
  # PUT /users/:user_id

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => user.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one user by ID
  # DELETE /users/:user_id

  def destroy
    User.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def user_params
    params.permit(:email, :password, :password_confirmation, :username)
  end
end
