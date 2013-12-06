require 'spec_helper'

describe User do
  # create one user and 20 topic, and let the 
  # user following odd id topic
  before(:each) do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create_list(:topic,20)
  end
  describe 'following_topics' do
    it 'following_topics should get all the topics the user are following' do
      # get all topic id of which id is odd
      following_topic_ids = Topic.pluck(:id).reject{|i| i%2 == 0}
      following_topic_ids.each do |id|
        FactoryGirl.create(:followship, user_id: @user.id, topic_id: id )
      end
      @user.following_topics.pluck(:id).should == following_topic_ids
    end
  end
  describe 'favoring_posts' do
    it 'should get all the topics the user are favoriing' do
      # create 20 post of topic1, favor odd id post
      FactoryGirl.create_list(:post,20)
      post_ids = Post.pluck(:id)
      favor_post_ids = post_ids.reject{|i| i%2 ==0}
      favor_post_ids.each do |p_id|
        FactoryGirl.create(:favor, user_id: @user.id, post_id: p_id)
      end
      @user.favoring_posts.pluck(:id) == favor_post_ids
    end
  end
end
