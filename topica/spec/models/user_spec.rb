require 'spec_helper'

describe User do
  describe 'following topics' do
    it 'should get all the topics the user are following' do
      user = FactoryGirl.create(:user)
      topic_lst = FactoryGirl.create_list(:topic,20)
      # get all topic id of which id is odd
      following_topic_ids = Topic.pluck(:id).reject{|i| i%2 == 0}
      following_topic_ids.each do |id|
        FactoryGirl.create(:followship, user_id: user.id, topic_id: id )
      end
      user.following_topics.pluck(:id).should == following_topic_ids
    end
  end
  describe 'favoring posts' do
    it 'should get all the topics the user are favoriing'
  end
end
