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

  # sunspot
  searchable do
    text      :title,    :boost => 2.0
    text      :content 
    integer   :user_id
    time      :created_at
    time      :updated_at
    # TODO temporay hack enable multi modle search to be group
    string    :type do |topic| topic.class.name end
  end

  def comment_size
    comments.size
  end

end
