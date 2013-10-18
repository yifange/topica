# Topic controller
# Basic GRUD implemented

class Api::V1::TopicsController < Api::V1::ApplicationController
  # Query for all the topics in descendent order
  def index
    render :json => Topic.all.order("created_at DESC")
  end

  # Query for one topic by id

  def show
    render :json => Topic.find(params[:id])  
  end

  # Create a new topic

  def create
    topic = Topic.new(topic_params)
    if topic.save
      render :json => topic, :status => :created
    else
      render :json => topic.errors, :status => :unprocessable_entity
    end
  end

  # Update an existing topic

  def update
    comemnt = topic.find(params[:id])
    if topic.update_attributes(topic_params)
      render :json => true, :head => :no_content
    else
      render :json => topic.errors, :status => :unprocessable_entity
    end
  end

  # Destroy one topic by ID

  def destroy
    Commnet.find(params[:id]).destroy
    render :json => true, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def topic_params
    params.require(:topic).permit(:user_id, :content)
  end
end
