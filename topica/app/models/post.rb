class Post < ActiveRecord::Base
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
  belongs_to :user, -> { select :id, :email, :username, :name}
  
  validates_presence_of :user
  
  has_many :favors, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :topics, :through => :categories
  has_many :favoring_users, -> { select "users.id", :email, :username, :name}, 
              :class_name => "User", :through => :favors, :source => :user

  def comment_size
    comments.size
  end

end
