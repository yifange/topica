class Followship < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  validates_uniqueness_of :user_id, :scope => :topic_id
end
