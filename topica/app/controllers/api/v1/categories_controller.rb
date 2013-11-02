class Api::V1::CategoriesController < Api::V1::ApplicationController
  def all_topics
    topic_ids = Category.find(params[:post_id]).map(&:topic_id)
    topics = Topic.where(:id => topic_ids)
    render :json => topics
  end

  def all_posts
    post_ids = Category.find(params[:topic_id]).map(&:post_id)
    posts = Post.where(:id => post_ids)
    render :json => posts
  end
  
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

  def destroy
    unless params.has_key? :topic_ids or params[:topics_ids].respond_to? :each
      render :json => {:ok => false, :message => "topic_ids required"}
    else
      Category.delete_all(:post_id => params[:post_id], :topic_id => params[:topic_ids])
      render :json => {:ok => true}, :head => :no_content
    end
  end
end
