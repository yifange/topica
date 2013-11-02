class Category < ActiveRecord::Base
  belongs_to :topic
  belongs_to :post
  validates_uniqueness_of :topic_id, :scope => :post_id
end
