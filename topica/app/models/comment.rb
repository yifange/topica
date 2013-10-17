class Comment < ActiveRecord::Base
  belongs_to :post
  validates_uniqueness_of :comment_content
  validates_uniqueness_of :comment_date
end
