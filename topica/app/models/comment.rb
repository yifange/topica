# Comment model

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, -> { select :id, :email, :username, :name}
  validates :user_id, :presence => true
  validates :post_id, :presence => true
  validates :content, :presence => true

  validates_presence_of :user
  validates_presence_of :post

  # sunspot
  searchable do
    text      :content
    integer   :user_id
    integer   :post_id
    time      :created_at
    time      :updated_at
    # TODO temporay hack enable multi modle search to be group
    string    :type do |topic| topic.class.name end
  end
end
