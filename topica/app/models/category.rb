class Category < ActiveRecord::Base
  belongs_to :topic
  belongs_to :post
  validates_uniqueness_of :topic_id, :scope => :post_id
  validates :topic_id, :presence => true
  validates :post_id, :presence => true

  # Extract create function for reuse when creating a post 
  #
  # def create_category(post_id, topic_ids)
  #   categories = []
  #   unless topic_ids.nil? or topic_ids.empty? or topic_ids.respond_to? :each
  #     render :json => {:ok => false, :message => "topic_ids required"}
  #   else
  #     topic_ids.each do |topic_id|
  #       categories << Category.new(:post_id => post_id, :topic_id => topic_id)
  #     end
  #     save_result = Category.import categories, :validate => true
  #     if save_result.failed_instances.empty?
  #       return true
  #       # render :json => {:ok => true}, :status => :created
  #     else
  #       return false
  #       # render :json => {:ok => false, :failed_instances => save_result.failed_instances.map {|i| i.topic_id}}, :status => :unprocessable_entity
  #     end
  #   end
  # end
end
