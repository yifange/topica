class Followship < ActiveRecord::Base
  # topics could stay out of feeds
  belongs_to :user, -> { select :id, :email, :username, :name}
  belongs_to :topic
  belongs_to :feed
  validates_uniqueness_of :user_id, :scope => :topic_id
  validates :user, :presence => true
  validates :topic, :presence => true
end
