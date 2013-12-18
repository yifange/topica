# Topic controller
#
# Author:: Yifan Ge
class Api::V1::TopicsController < Api::V1::ApplicationController

  # Query for all the topics of a user
  # GET     /api/v1/users/:user_id/topics
  def index
    render :json => User.find(params[:user_id]).topics
  end
  
  # Query for all topics of a user, return a list of topics with number of posts and number of followers
  # GET    /api/v1/users/:user_id/detailed_topics
  def detail_index
    render :json => User.find(params[:user_id]).topics.includes(:posts, :followships), :methods => [:posts_size, :followers_size]
  end

  # Query for all the posts of the user
  #
  # GET /topics/:topic_id/posts
  def all_posts
    posts = Topic.find(params[:topic_id]).posts
    render :json => posts.order(:created_at => :desc), :include => {:topics => {}, :user => {}}, :methods => [:comment_size]
  end

  # Query for one topic by id
  # GET     /api/v1/topics/:id
  def show
    render :json => Topic.find(params[:id])  
  end

  # Create a new topic
  # params:
  # user_id
  # name
  # feed_id
  #
  # POST    /api/v1/users/:user_id/topics
  def create
    topic = Topic.new(:name => params[:name], :topic_type => params[:topic_type], :user_id => current_user.id)
    if topic.save
      followship = Followship.new(:user_id => params[:user_id], :topic_id => topic.id)
      if followship.save
        render :json => topic, :status => :created
      else
        render :json => {:ok => false, :message => followship.errors}, :status => :unprocessable_entity
      end
    else
      render :json => {:ok => false, :message => topic.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing topic
  # Params:
  # PATCH   /api/v1/topics/:id
  # PUT     /api/v1/topics/:id
  def update
    topic = Topic.find(params[:id])
    if topic.update_attributes(topic_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => topic.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one topic by ID
  #
  # DELETE  /api/v1/topics/:id
  def destroy
    Topic.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  # Get all the following users of a topic
  #
  # GET     /api/v1/topics/:topic_id/followers 
  def all_following_users
    users = Topic.find(params[:topic_id]).following_users
    render :json => users
  end

  private
  # Whitelist the required fields in params hash

  def topic_params
    params.permit(:user_id, :name, :topic_type)
  end
end
