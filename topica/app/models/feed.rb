class Feed < ActiveRecord::Base
  belongs_to :user, -> { select :id, :email, :username, :name}
  has_many :followships
  validates_uniqueness_of :user_id, :scope => :name
  validates :user_id, :presence => true
  validates :name, :presence => true

  has_many :topics, :through => :followships
  has_many :posts, :through => :topics
  
  # sunspot
  searchable do
    text      :name
    integer   :user_id
    time      :created_at
    time      :updated_at
    # TODO temporay hack enable multi modle search to be group
    string    :type do |topic| topic.class.name end

  def topic_size
    topics.size
  end
end
