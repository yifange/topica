# Topic controller
# Basic GRUD implemented
# You have three ways to get to a topic resource.
# 1) Directly via the topic id
# 2) Specify the user id and the feed id
# 3) Specify the user id
class Api::V1::TopicsController < Api::V1::ApplicationController
  # Query for all the topics in descendent order
  # GET /topics
  # or
  # GET /users/:user_id/feeds/:feed_id/topics
  # or
  # GET /users/:user_id/topics
  def index
    if params.has_key? :feed_id
      render :json => Topic.where(:user_id => params[:user_id], :feed_id => params[:feed_id])
    else
      render :json => Topic.where(:user_id => params[:user_id])
    end
  end

  # Query for one topic by id
  # Params:
  # +id+:: feed_id
  # GET /topics/:topic_id
  # or
  # GET /users/:user_id/feeds/:feed_id/topics/:topic_id
  # or
  # GET /users/:user_id/topics/:topic_id

  def show
    render :json => Topic.find(params[:id])  
  end

  # Create a new topic
  # Params:
  # +topic+:: Hash of the topic object to be created
  # POST /topics
  # or
  # POST /users/:user_id/feeds/:feed_id/topics
  # or
  # POST /users/:user_id/topics

  def create
    topic = Topic.new(topic_params)
    if topic.save
      render :json => topic, :status => :created
    else
      render :json => {:ok => false, :message => topic.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing topic
  # Params:
  # +id+:: Feed id
  # +topic+:: Hash of the topic object to be created
  # PUT /topics/:topic_id
  # or
  # PUT /users/:user_id/feeds/:feed_id/topics/:topic_id
  # or
  # PUT /users/:user_id/topics/:topic_id

  def update
    topic = Topic.find(params[:id])
    if topic.update_attributes(topic_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => topic.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one topic by ID
  # DELETE /topics/:topic_id
  # or
  # DELETE /users/:user_id/feeds/:feed_id/topics/:topic_id
  # or
  # DELETE /users/:user_id/topics/:topic_id

  def destroy
    Topic.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def topic_params
    params.permit(:user_id, :name, :feed_id)
  end
end
