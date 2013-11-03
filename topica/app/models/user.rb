class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, presence: true 
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  has_many :topics
  has_many :followships
  has_many :favors
  has_many :posts
  has_many :feeds
  has_many :comments

  def following_topics
    topic_ids = Followship.where(:user_id => id).map(&:topic_id)
    topics = Topic.where(:id => topic_ids)
  end
  def favoring_posts
    post_ids = Favor.where(:user_id => id).map(&:post_id)
    posts = Post.where(:id => post_ids)
  end
end
