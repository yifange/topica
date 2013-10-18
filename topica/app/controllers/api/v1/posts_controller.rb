# Post controller

class Api::V1::PostsController < Api::V1::ApplicationController

  # Query for all the posts in descendent order
  def index
    render :json => Post.all.order("created_at DESC")
  end

  # Query for one post by id

  def show
    render :json => Post.find(params[:id])  
  end

  # Create a new post

  def create
    post = Post.new(post_params)
    if post.save
      render :json => post, :status => :created
    else
      render :json => post.errors, :status => :unprocessable_entity
    end
  end

  # Update an existing post

  def update
    comemnt = post.find(params[:id])
    if post.update_attributes(post_params)
      render :json => true, :head => :no_content
    else
      render :json => post.errors, :status => :unprocessable_entity
    end
  end

  # Destroy one post by ID

  def destroy
    Commnet.find(params[:id]).destroy
    render :json => true, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def post_params
    params.require(:post).permit(:user_id, :content)
  end
end
