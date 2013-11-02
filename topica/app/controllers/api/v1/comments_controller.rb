# Comment controller
#
# Author:: Yifan Ge

class Api::V1::CommentsController < Api::V1::ApplicationController
 
  # Query for all the comments in descendent order
  # GET      /api/v1/users/:user_id/comments
  # GET      /api/v1/users/:user_id/posts/:post_id/posts/:post_id/comments
  
  def index
    render :json => Comment.all.order("created_at DESC")
  end

  # Query for one comment by id
  # GET      /api/v1/users/:user_id/comments/:id 
  # GET      /api/v1/users/:user_id/posts/:post_id/posts/:post_id/comments/:id

  def show
    render :json => Comment.find(params[:id])  
  end

  # Create a new comment
  # POST     /api/v1/users/:user_id/posts/:post_id/posts/:post_id/comments
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render :json => comment, :status => :created
    else
      render :json => {:ok => false, :message => comment.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing comment
  # PATCH    /api/v1/users/:user_id/posts/:post_id/posts/:post_id/comments/:id
  # PUT      /api/v1/users/:user_id/posts/:post_id/posts/:post_id/comments/:id

  def update
    comemnt = Comment.find(params[:id])
    if comment.update_attributes(comment_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => comment.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one comment by ID

  def destroy
    Comment.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def comment_params
    params.permit(:user_id, :post_id, :content)
  end
end
