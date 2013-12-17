class Topic < ActiveRecord::Base
  belongs_to :user, -> { select :id, :email, :username, :name}

  validates :user_id, :presence => true
  has_many :followships

  has_many :posts, :through => :categories
  has_many :categories, :dependent => :destroy

  validates_inclusion_of :topic_type, :in => [0, 1]
  has_many :following_users, -> { select "users.id", :email, :username, :name}, 
           :class_name => "User", :through => :followships, :source => :user

  #sunspot search
  searchable do
    text      :name,      :boost => 2.0  
    integer   :user_id
    time      :created_at
    time      :updated_at
    # TODO temporay hack enable multi modle search to be group
    string    :type do |topic| topic.class.name end
  end

  def posts_size
    posts.size
  end

  def followers_size
    followships.size
  end
end
