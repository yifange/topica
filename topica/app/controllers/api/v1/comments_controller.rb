# Comment controller

class Api::V1::CommentsController < Api::V1::ApplicationController
 
  # Query for all the comments in descendent order
  def index
    render :json => Comment.all.order("created_at DESC")
  end

  # Query for one comment by id

  def show
    render :json => Comment.find(params[:id])  
  end

  # Create a new comment

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render :json => comment, :status => :created
    else
      render :json => comment.errors, :status => :unprocessable_entity
    end
  end

  # Update an existing comment

  def update
    comemnt = comment.find(params[:id])
    if comment.update_attributes(comment_params)
      render :json => true, :head => :no_content
    else
      render :json => comment.errors, :status => :unprocessable_entity
    end
  end

  # Destroy one comment by ID

  def destroy
    Commnet.find(params[:id]).destroy
    render :json => true, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def comment_params
    params.require(:comment).permit(:user_id, :content)
  end
end
