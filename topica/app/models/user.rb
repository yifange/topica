class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :username, presence: true
  validates :email, presence: true
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
  has_many :following_topics, :class_name => "Topic", :through => :followships, :source => :topic
  has_many :following_posts, :class_name => "Post", :through => :following_topics, :source => :posts
  has_many :favoring_posts, :class_name => "Post", :through => :favors, :source => :post

  # solr
  searchable do
    text :username
    time :created_at
    time :updated_at
  end


end
