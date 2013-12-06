class Post < ActiveRecord::Base
  has_many :favors, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :topics, :through => :categories
  has_many :favoring_users, -> { select "users.id", :email, :username, :name}, :class_name => "User", :through => :favors, :source => :post
  def comment_size
    comments.size
  end

  def user
    topics.first.user.select(:id, :email, :username, :name)
  end
end
