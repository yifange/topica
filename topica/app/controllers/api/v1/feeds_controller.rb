# Feed controller
#
# Author:: Yifan Ge

class Api::V1::FeedsController < Api::V1::ApplicationController

  # Query for all the feeds in descendent order
  # GET     /api/v1/users/:user_id/feeds 
  def index
    render :json => User.find(params[:user_id]).feeds.includes(:topics).order(:created_at => :asc), :methods => :topic_size
  end

  # Get all the topics of a feed
  # GET     /api/v1/posts/:post_id/topics
  def all_topics
    topics = Feed.find(params[:feed_id]).topics
    render :json => topics
  end

  # Query for one feed by id
  # GET /feeds/:feed_id

  def show
    render :json => Feed.find(params[:id])  
  end

  # Create a new feed
  # Params:
  # POST:
  # name
  # POST    /api/v1/users/:user_id/feeds 

  def create
    feed = Feed.new(:user_id => params[:user_id], :name => params[:name])
    if feed.save
      render :json => feed, :status => :created
    else
      render :json => {:ok => false, :message => feed.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing feed
  # Params:
  # +id+:: Feed id
  # +feed+:: Hash of the feed object to be created
  # PUT /feeds/:feed_id
  # or
  # PUT /users/:user_id/feeds/:feed_id
  
  def update
    feed = Feed.find(params[:id])
    if feed.update_attributes(feed_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => feed.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one feed by ID
  #
  # DELETE  /api/v1/feeds/:id
  def destroy
    Feed.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def feed_params
    params.permit(:user_id, :name)
  end

end
