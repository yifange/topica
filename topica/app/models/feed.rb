class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :followships
  validates_uniqueness_of :user_id, :scope => :name
  validates :user_id, :presence => true
  validates :name, :presence => true
end
