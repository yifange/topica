class Category < ActiveRecord::Base
  belongs_to :topic
  belongs_to :post
  validates_uniqueness_of :topic_id, :scope => :post_id
  validates :topic_id, :presence => true
  validates :post_id, :presence => true

  # Extract create function for reuse when creating a post 
  #
  def create_category
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
end
