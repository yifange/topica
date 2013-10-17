class User < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_uniqueness_of :email

  has_many :topics
  has_many :feeds
  has_many :posts, through: :favors
  accepts_nested_attributes_for :favors
end
