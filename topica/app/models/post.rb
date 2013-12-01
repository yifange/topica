class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  has_many :users, :through => :favors
  has_many :comments, :dependent => :destroy
  has_many :topics, :through => :categories
  attr_accessor :num_of_comments
  def favoring_users
    user_ids = Favor.where(:post_id => id).map &:user_id
    users = User.where(:id => user_ids).select(:id, :email, :username)
  end
  
  def get_num_of_comments
    comments.count
  end
  def attributes
    {:id => nil, :user_id => nil, :topic_id => nil, :title => nil, :content => nil, :created_at => nil, :updated_at => nil, :num_of_comments => nil}
  end
end
