require 'spec_helper'

describe Topic do
  describe 'following_users' do
    it 'should get all the users who are following this topic' do
      USER_NUM = 10
      FactoryGirl.create_list(:user,USER_NUM)
      user_ids = User.all.pluck(:id)
      FactoryGirl.create_list(:topic,2)
      #get odd id topic
      following_topic_ids = Topic.pluck(:id).reject{|i| i%2 == 0}
      topic_ids_no_following = Topic.pluck(:id).reject{|i| i%2 != 0}
      followers = Array.new(0) # followers[0] store followers of topic 0
      rd = Random.new
      # each topic followed by random number of user (0-100)
      following_topic_ids.each do |topic_id|
        num = rd.rand(USER_NUM)
        curr_topic_follower_user_ids = user_ids.sample(num)
        curr_topic_follower_user_ids.each do |i|
          FactoryGirl.create(:followship, user_id: i, topic_id: topic_id)
        end
        followers << curr_topic_follower_user_ids
      end
      #test
      i = 0
      following_topic_ids.each do |topic_id|
        expect(Topic.find(topic_id).following_users.
               pluck(:id)).to eq(followers.at(i).sort)
        i += 1
      end

      #test topic not followed by any user
      topic_ids_no_following.each do |topic_id|
        Topic.find(topic_id).following_users.should be_empty
      end

    end
  end
end
