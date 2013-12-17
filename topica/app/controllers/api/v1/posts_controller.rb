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
    render :json => User.find(params[:user_id]).posts.includes(:topics), :order => {:updated_at => :desc}, :include => "topics"
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
    post = Post.new(:user_id => current_user.id,
                    :title => params[:title], 
                    :content => params[:content])
    if params.include?(:topic_ids) and post.save
      categories = []
      params[:topic_ids].each do |topic_id|
        categories << Category.new(:post_id => post[:id], :topic_id => topic_id)
      end
      save_result = Category.import categories, :validate => true
      unless save_result.failed_instances.empty?
        render :json => {:ok => false, 
                         :failed_instances => save_result.failed_instances.
                                                map {|i| i.topic_id}}, 
                         :status => :unprocessable_entity
      else
        render :json => post, :status => :created
      end
    else
      render :json => {:ok => false, :message => post.errors}, 
                       :status => :unprocessable_entity
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
    params.permit(:title, :content, :topic_ids)
  end
end
