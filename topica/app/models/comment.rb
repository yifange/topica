# Comment model

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, -> { select :id, :email, :username, :name}
  validates :user_id, :presence => true
  validates :post_id, :presence => true
  validates :content, :presence => true
end
