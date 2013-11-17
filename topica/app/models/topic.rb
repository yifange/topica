class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  validates :user_id, :presence => true
  has_many :followships
  has_many :users, :through => :followships
  has_many :posts, :through => :categories

  validates_inclusion_of :topic_type, :in => ["PUBLIC", "PRIVATE"]
  def following_users
    user_ids = Followship.where(:topic_id => id).map &:user_id
    users = User.where(:id => user_ids).select(:id, :email, :username)
  end
end
