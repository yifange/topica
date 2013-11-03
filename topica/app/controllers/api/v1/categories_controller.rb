# POST     /api/v1/users/:user_id/posts/:post_id/topics/delete##
# The controller for all categories, which is the reletionship class between topic and post.
# 
# Author:: Yifan Ge
#
class Api::V1::CategoriesController < Api::V1::ApplicationController
  ##
  # return all the topics of a given post
  # GET     /api/v1/posts/:post_id/topics
  def all_topics
    topic_ids = Category.where(:post_id => params[:post_id]).map(&:topic_id)
    topics = Topic.where(:id => topic_ids)
    render :json => topics
  end
  
  ## 
  # return all posts for a given topic
  # GET      /api/v1/topics/:topic_id/posts 
  def all_posts
    post_ids = Category.where(:topic_id => params[:topic_id]).map(&:post_id)
    posts = Post.where(:id => post_ids)
    render :json => posts
  end
  
  ##
  # add topics for a post
  # params:
  # POST:
  # topic_ids (list)
  #
  # POST    /api/v1/posts/:post_id/topics                  
  #
  def create
    categries = []
    unless params.has_key? :topic_ids or params[:topic_ids].repond_to? :each
      render :json => {:ok => false, :message => "topic_ids required"}
    else
      params[:topic_ids].each do |topic_id|
        categries << Category.new(:post_id => params[:post_id], :topic_id => topic_id)
      end
      save_result = Category.import categries, :validate => true
      if save_result.failed_instances.empty?
        render :json => {:ok => true}, :status => :created
      else
        render :json => {:ok => false, :failed_instances => save_result.failed_instances.map {|i| i.topic_id}}, :status => :unprocessable_entity
      end
    end
  end
  
  ##
  # Remove topics from a post
  #
  # params:
  # POST:
  # topic_ids (list)
  #
  # POST    /api/v1/posts/:post_id/topics/delete           
  #
  def destroy
    unless params.has_key? :topic_ids or params[:topics_ids].respond_to? :each
      render :json => {:ok => false, :message => "topic_ids required"}
    else
      Category.delete_all(:post_id => params[:post_id], :topic_id => params[:topic_ids])
      render :json => {:ok => true}, :head => :no_content
    end
  end
end
