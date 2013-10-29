class User < ActiveRecord::Base
  has_many :topics
  # has_many :topics, :through => :followships
  has_many :followships
  has_many :favors
  has_many :posts
  # has_many :posts, :through => :favors
  has_many :feeds
  has_many :comments
  def self.following_topic
  end
  def self.favored_posts
  end
end
