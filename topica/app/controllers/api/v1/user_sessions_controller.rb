class Api::V1::UserSessionsController < ApplicationController
  # def new
  #   @user = User.new
  # end

  def create
    if @user = login(params[:email], params[:password])
      render json: {text: "Login successful."}
    else
      render json: {text: "Login failed"}, status: :unauthorized
    end
  end

  def destroy
    logout
    render json: {text: "Logged out"}
  end
end
