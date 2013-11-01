class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  validates :user_id, :presence => true
  has_many :followships
  has_many :users, :through => :followships
end
