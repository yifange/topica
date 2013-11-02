class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  has_many :users, :through => :favors
  has_many :comments, :dependent => :destroy
  has_many :topics, :through => :categories

  def favoring_users
    user_ids = Favor.where(:post_id => id).map &:user_id
    users = User.where(:id => user_ids).select(:id, :email, :username)
  end
end
