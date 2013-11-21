class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :topics
  validates_uniqueness_of :name
end
