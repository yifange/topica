class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comment
  validates_uniqueness_of :content, :date
end
