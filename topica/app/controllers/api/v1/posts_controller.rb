# Post controller
# Basic GRUD implemented
# Post is also defined as a nested resource of user, so you can specify the user id for the post in the URL
class Api::V1::PostsController < Api::V1::ApplicationController

  # Query for all the posts in descendent order
  # GET /posts
  # or
  # GET /users/:user_id/posts
  def index
    render :json => Post.all.order("created_at DESC")
  end

  # Query for one post by id
  # Params:
  # +id+:: post_id
  # GET /posts/:post_id
  # or
  # GET /users/:user_id/posts/:post_id

  def show
    render :json => Post.find(params[:id])  
  end

  # Create a new post
  # Params:
  # +post+:: Hash of the post object to be created
  # POST /posts
  # or
  # POST /users/:user_id/posts

  def create
    post = Post.new(post_params)
    if post.save
      render :json => post, :status => :created
    else
      render :json => {:ok => false, :message => post.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing post
  # Params:
  # +id+:: Post id
  # +post+:: Hash of the post object to be created
  # PUT /posts/:post_id
  # or
  # PUT /users/:user_id/posts/:post_id

  def update
    post = Post.find(params[:id])
    if post.update_attributes(post_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => post.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one post by ID
  # DELETE /post/:post_id
  # or
  # DELETE /users/:user_id/posts/:post_id

  def destroy
    Post.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def post_params
    params.require(:post).permit(:user_id, :topic_id, :title, :content)
  end
end
