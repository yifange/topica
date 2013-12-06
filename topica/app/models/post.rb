class Post < ActiveRecord::Base
  has_many :favors, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :topics, :through => :categories
  def favoring_users
    user_ids = favors.map &:user_id
    users = User.where(:id => user_ids).select(:id, :email, :username)
  end
  def user
    topics.first.user
  end
end
