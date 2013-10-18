class User < ActiveRecord::Base
  has_many :topics
  has_many :followships
  has_many :favors
  has_many :posts
  has_many :feeds
  def self.following_topic
  end
  def self.favored_posts
  end
end
