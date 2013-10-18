# Feed controller
# Basic GRUD implemented

class Api::V1::FeedsController < Api::V1::ApplicationController

  # Query for all the feeds in descendent order
  def index
    render :json => Feed.all.order("created_at DESC")
  end

  # Query for one feed by id

  def show
    render :json => Feed.find(params[:id])  
  end

  # Create a new feed

  def create
    feed = Feed.new(feed_params)
    if feed.save
      render :json => feed, :status => :created
    else
      render :json => feed.errors, :status => :unprocessable_entity
    end
  end

  # Update an existing feed

  def update
    comemnt = feed.find(params[:id])
    if feed.update_attributes(feed_params)
      render :json => true, :head => :no_content
    else
      render :json => feed.errors, :status => :unprocessable_entity
    end
  end

  # Destroy one feed by ID

  def destroy
    Commnet.find(params[:id]).destroy
    render :json => true, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def feed_params
    params.require(:feed).permit(:user_id, :content)
  end

end
