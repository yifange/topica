class Favor < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :user_id, :scope => :post_id
  validates :user_id, :presence => true
  validates :post_id, :presence => true
end
