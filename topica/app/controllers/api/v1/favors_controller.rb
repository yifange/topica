class Api::V1::FavorsController < Api::V1::ApplicationController
  def index
    post_ids = Favor.where(:user_id => params[:user_id]).map(&:post_id)
    posts = Post.where(:id => post_ids)
    render :json => posts
  end
  def all_favorers
    user_ids = Favor.where(:post_id => params[:post_id]).map(&:user_id)
    users = User.where(:id => user_ids).select(:id, :email, :username)
    render :json => users
  end
  def create
    favor = Favor.new(:user_id => params[:user_id], :post_id => params[:post_id])
    if favor.save
      render :json => favor, :status => :created
    else
      render :json => {:ok => false, :message => favor.errors}, :status => :unprocessable_entity
    end
  end
  def destroy
    favor = Favor.where(:user_id => params[:user_id], :post_id => params[:post_id])
    favor.destroy
    render :json => {:ok => true}, :head => :no_content
  end
end
