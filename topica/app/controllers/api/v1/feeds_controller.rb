# Feed controller
# Basic GRUD implemented
# Feed is also defined as a nested resource of user, so you can specify the user id for the feed in the URL

class Api::V1::FeedsController < Api::V1::ApplicationController

  # Query for all the feeds in descendent order
  # GET /feeds
  # or
  # GET /users/:user_id/feeds
  def index
    render :json => Feed.all.order("created_at DESC")
  end

  # Query for one feed by id
  # Params:
  # +id+:: feed_id
  # GET /feeds/:feed_id
  # or
  # GET /users/:user_id/feeds/:feed_id

  def show
    render :json => Feed.find(params[:id])  
  end

  # Create a new feed
  # Params:
  # +feed+:: Hash of the feed object to be created
  # POST /feeds
  # or
  # POST /users/:user_id/feeds

  def create
    feed = Feed.new(feed_params)
    if feed.save
      render :json => feed, :status => :created
    else
      render :json => feed.errors, :status => :unprocessable_entity
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
      render :json => true, :head => :no_content
    else
      render :json => feed.errors, :status => :unprocessable_entity
    end
  end

  # Destroy one feed by ID
  # DELETE /feeds/:feed_id
  # or
  # DELETE /users/:user_id/feeds/:feed_id
  def destroy
    Feed.find(params[:id]).destroy
    render :json => true, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def feed_params
    params.require(:feed).permit(:user_id, :content)
  end

end
