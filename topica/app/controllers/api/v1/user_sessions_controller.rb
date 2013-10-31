class Api::V1::UserSessionsController < Api::V1::ApplicationController
  # def new
  #   @user = User.new
  # end

  def create
    puts params[:email]
    puts params[:password]
    if @user = login(params[:email], params[:password])
      render json: {:ok => true}
    else
      render json: {:ok => false}, status: :unauthorized
    end
  end

  def destroy
    logout
    render json: {:ok => true}
  end

end
