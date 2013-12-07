class Feed < ActiveRecord::Base
  belongs_to :user, -> { select :id, :email, :username, :name}
  has_many :followships
  validates_uniqueness_of :user_id, :scope => :name
  validates :user_id, :presence => true
  validates :name, :presence => true

  has_many :topics, :through => :followships
  has_many :posts, :through => :topics
end
