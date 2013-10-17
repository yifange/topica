class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :topic
  validates_uniqueness_of :feed_name
end
