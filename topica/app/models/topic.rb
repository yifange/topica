class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  has_many :followships
  has_many :users, :through => :followships
end
