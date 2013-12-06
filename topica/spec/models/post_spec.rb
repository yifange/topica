require 'spec_helper'

describe Post do
  before(:each) do
    @rd = Random.new
    # generate 20 users
    FactoryGirl.create_list(:user,20)
    @user_ids = User.pluck(:id)
    # create 20 post
    FactoryGirl.create_list(:post, 20)
    @post_ids = Post.pluck(:id)
  end

  describe 'favoring_users' do
    it 'should get all the users who are favoriing this post' do
      #[[]], favor_users[i] contain all user id who favor i-th post
      favor_users = Array.new(0)
      @post_ids.each do |p_id| 
        post_favor_users_id = []
        # create favor by each post favored by random number of users
        (1...@rd.rand(@user_ids.length)).each do |i|
          u_id = @user_ids.at(i)
          post_favor_users_id << u_id 
          FactoryGirl.create(:favor, user_id: u_id, post_id: p_id )
        end
        favor_users << post_favor_users_id
      end
     
      #test
      i = 0
      @post_ids.each do |p_id|
        Post.find(p_id).favoring_users.pluck(:id).should == favor_users.at(i)
        i += 1
      end
    end #end it
  end
=begin
  describe 'get_num_of_comments' do
    it 'should return the total number of comments of this post' do
      posts_comments_num = [] # ith element contain num of comment on @post[i]
      max_comments_num = 100
      #each post with random number of comment from random user
      @post_id.each do |p_id|
        num = rd.rand(100)
        posts_comments_num << num
        (1...num).each do |i|
          FactoryGirl.create(:comment, post_id: p_id, user_id: @user_ids.sample)
        end
      end

      i = 0
      @post_ids.each do |p_id|
        Post.find(p_id).get_num_of_comments.should == posts_comments_num.at(i)
        i += 1
      end

    end #end it
  end
=end

end
