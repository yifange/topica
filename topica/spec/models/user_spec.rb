require 'spec_helper'
require 'models/model_helpers'

RSpec.configure do |c|
    c.include ModelHelpers
end

describe User do
  context 'create user' do
    it 'should require username' do
     FactoryGirl.build(:user, username: '').should_not be_valid
    end
    it 'should require email' do
      FactoryGirl.build(:user, email: '').should_not be_valid
    end
    it 'should requrre password' do
      FactoryGirl.build(:user, password: '').should_not be_valid
    end
    it 'should require password_confirmation' do
      FactoryGirl.build(:user, password_confirmation: '').
        should_not be_valid
    end
    it 'should require password and password_confirmation match' do
      FactoryGirl.build(:user, password: '123', password_confirmation: '456').
        should_not be_valid
    end
    it 'should require unique email' do
      user = FactoryGirl.create(:user)
      FactoryGirl.build(:user, email: user.email).should_not be_valid
    end
  
  end # end of create user

  context 'after valid users are created' do
    # create one user and 20 topic, and let the 
    # user following odd id topic
    before(:each) do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:topic,20)
    end
    describe 'following' do
      before(:each) do
        @following_topic_ids = create_followship_odd_idx_topic(
                                  Topic.pluck(:id), @user.id)
      end
      describe 'following_topics' do
        it 'following_topics should get all the topics the user are following' do
          @user.following_topics.pluck(:id).should ==  @following_topic_ids
        end
      end
      describe 'following_posts' do
        it 'should get all the posts belongs to the topics following' do
          post_ids = FactoryGirl.create_list(:post, 30, user_id: @user.id).
                                  map{|post| post.id}
          all_topic_ids = Topic.pluck(:id)
          # each post assign to random topic
          r = []
          post_ids.each do |p_id|
            t_id = all_topic_ids.sample
            FactoryGirl.create(:category, topic_id: t_id, post_id: p_id)
            if @following_topic_ids.include?(t_id)
              r << p_id
            end
          end
          @user.following_posts.pluck(:id).sort.should == r
        end
      end
    end 
    describe 'favoring_posts' do
      it 'should get all the posts the user are favoriing' do
        # create 20 post of topic1, favor odd id post
        FactoryGirl.create_list(:post,20, user_id: @user.id)
        post_ids = Post.pluck(:id)
        #favoring odd index post
        favor_post_ids = post_ids.reject{|i| i%2 ==0}
        favor_post_ids.each do |p_id|
          FactoryGirl.create(:favor, user_id: @user.id, post_id: p_id)
        end
        @user.favoring_posts.pluck(:id).should == favor_post_ids
      end
    end

  end #end of vailid user created
end
