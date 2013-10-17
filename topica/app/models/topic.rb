class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  validates_presence_of :user
  validates_presence_of :topic_name
  validates_presence_of :type
end
