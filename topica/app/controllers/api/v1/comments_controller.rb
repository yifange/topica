# Comment controller
# Basic GRUD implemented
# Comment is also defined as a nested resource of post and user, so you can specify the user id and post id for the comment in the URL

class Api::V1::CommentsController < Api::V1::ApplicationController
 
  # Query for all the comments in descendent order
  # GET /comments
  # or
  # GET /users/:user_id/posts/:post_id/comments
  def index
    render :json => Comment.all.order("created_at DESC")
  end

  # Query for one comment by id
  # Params:
  # +id+:: comment id
  # GET /comments/:comment_id
  # or
  # GET /users/:user_id/posts/:post_id/comments/:comment_id

  def show
    render :json => Comment.find(params[:id])  
  end

  # Create a new comment
  # Params:
  # +comment+:: Hash of the comment object to be created
  # POST /comments
  # or
  # POST /users/:user_id/posts/:post_id/comments
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render :json => comment, :status => :created
    else
      render :json => {:ok => false, :message => comment.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing comment
  # Params:
  # +id+:: Comment id
  # +comment+:: Hash of the comment object to be created
  # PUT /comments/comment_id

  def update
    comemnt = Comment.find(params[:id])
    if comment.update_attributes(comment_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => comment.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one comment by ID
  # DELETE /comments/:comment_id
  # or
  # DELETE /uesrs/:user_id/comments/:comment_id

  def destroy
    Comment.find(params[:id]).destroy
    render :json => {:ok => true}, :head => :no_content
  end

  private
  # Whitelist the required fields in params hash

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
