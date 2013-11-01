class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  validates :user_id, :presence => true
  has_many :users, :through => :favors
  has_many :comments, :dependent => :destroy

end
