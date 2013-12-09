# Comment controller
#
# Author:: Yifan Ge

class Api::V1::CommentsController < Api::V1::ApplicationController
 
  # All the comments of a specific post
  #
  # GET     /api/v1/posts/:post_id/comments
  def index
    render :json => Post.find(params[:post_id]).comments.includes(:user), :include => {:user => {:only => [:username, :id, :email]}}
  end

  # Query for one comment by id
  #
  # GET     /api/v1/comments/:id 

  def show
    render :json => Comment.find(params[:id])  
  end

  # Create a new comment
  #
  # params: 
  # POST:
  # user_id
  # content
  #
  # POST    /api/v1/posts/:post_id/comments
  
  def create
    comment = Comment.new(:content => params[:content], :user_id => current_user.id)
    if comment.save
      render :json => comment, :status => :created
    else
      render :json => {:ok => false, :message => comment.errors}, :status => :unprocessable_entity
    end
  end

  # Update an existing comment
  #
  # params: 
  # POST:
  # user_id
  # content
  #
  # PATCH   /api/v1/comments/:id
  # PUT     /api/v1/comments/:id

  def update
    comemnt = Comment.find(params[:id])
    if comment.update_attributes(comment_params)
      render :json => {:ok => true}, :head => :no_content
    else
      render :json => {:ok => false, :message => comment.errors}, :status => :unprocessable_entity
    end
  end

  # Destroy one comment by ID
  #
  # DELETE  /api/v1/comments/:id                           

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
