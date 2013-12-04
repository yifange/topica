# Post controller
# 
# Author:: Yifan Ge
class Api::V1::PostsController < Api::V1::ApplicationController
  

  ##
  # Get all the favorers of a post
  #
  # GET /api/v1/posts/:post_id/favors
  
  def all_favorers
    users = Post.find(params[:post_id]).favoring_users
    render :json => users
  end

  # Query for all the posts of the user
  #
  # GET /users/:user_id/posts
  def index
    topics_id = Topic.where(:user_id => params[:user_id]).map &:id
    posts_id = (Category.where(:topic_id => topics_id).map &:post_id).unique
    posts = Post.where(:id => posts_id)
    render :json => posts.order(:created_at => :desc)
  end

  # Query for one post by id
  #
  # GET /posts/:post_id
  def show
    render :json => Post.find(params[:id])  
  end

  # Create a new post
  # Params:
  # +post+:: Hash of the post object to be created
  # title
  # content
  # POST /users/:user_id/posts

  def create
    post = Post.new(post_params)
    if post.save
      Category.create_category(post_params)
      render :json => post, :status => :created
    else
      render :json => {:ok => false, :message => post.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing post
  # Params:
  # +post+:: Hash of the post object to be created
  # title
  # content
  # PATCH   /api/v1/posts/:id
  # PUT     /api/v1/posts/:id
  def update
    post = Post.find(params[:id])
    if post.update_attributes(post_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => post.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one post by ID
  #
  # DELETE  /api/v1/posts/:id
  def destroy
    Post.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def post_params
    params.permit(:title, :content)
  end
end
