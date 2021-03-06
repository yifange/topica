# User session controller
# Where login and logout happen
#
# Author:: Yifan Ge
class Api::V1::UserSessionsController < Api::V1::ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  skip_before_filter :require_login, :create

  # Create a user session aka login
  # POST    /api/v1/login 
  def create
    if @user = login(params[:email], params[:password], params[:remember])
      render json: {:ok => true, :user => {:id => @user.id, :username => @user.username, :email => @user.email}}
    else
      render json: {:ok => false}, status: :unprocessable_entity
    end
  end
  
  # Destroy a user session aka logout
  # GET     /api/v1/logout
  def destroy
    logout
    render json: {:ok => true}
  end

  def me
    render json: current_user
  end

end
