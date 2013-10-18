class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :users, :throught => :favors
  has_many :comments
end
