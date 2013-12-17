require 'spec_helper'
require 'models/model_helpers'
include Sorcery::TestHelpers::Rails
include Sorcery::Controller::InstanceMethods

RSpec.configure do |c|
  c.include ModelHelpers
end

describe Api::V1::UsersController do
  # test when user not log in
  context 'not login' do
    describe "all_comments" do
      it "should return :unauthorized" do
        debugger
        get :all_comments, :user_id => 1
        expect(response.status).to eq(401)
      end
    end
    describe "index" do
      it "should return :unauthorized" do
        get :index
        expect(response.status).to eq(401)
      end
    end
    describe 'show' do
      it 'should return :unauthorized' do
        get :show, {:id => 1}
        expect(response.status).to eq(401)
      end
    end
    describe 'all_favoring_posts' do
      it 'should return :unauthorized' do
        get :all_favoring_posts, {:user_id => 1}
        expect(response.status).to eq(401)
      end
    end
    describe 'update' do
      it 'should return :unauthorized' do
        put :update, {:id => 1, 
          :user => FactoryGirl.attributes_for(:user)}
        expect(response.status).to eq(401)
      end
    end
    describe 'destroy' do
      it 'should return :unauthorized' do
        delete :destroy, {:id => 1}
        expect(response.status).to eq(401)
      end
    end
    describe "create" do
      it "should return :create(201) if user can successful saved" do
        user = FactoryGirl.build(:user)
        User.stub(:save).and_return(true)
        post  :create, FactoryGirl.attributes_for(:user)
        expect(response.status).to eq(201)
      end
      it "should return :unprocessable_entity(422) if user cannot be saved" do
        User.stub(:save).and_return(false)
        post :create
        expect(response.status).to eq(422)
      end
    end
  end

  # test when logged in
  context 'login' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      expect(response.status).to eq(200)
      login_user(@user)
      current_user.nil?.should == false
    end

    describe 'all_comments' do
      it "should return the json format of all the comments of given user_id" do
        topic_id = FactoryGirl.create(:topic, user_id: @user.id).id
        post_id = FactoryGirl.create(:post, user_id: @user.id).id
        comments = FactoryGirl.create_list(:comment, 2, 
                                           post_id: post_id, user_id: @user.id)
        get :all_comments, {:user_id => @user.id} 
        expect(response.status).to eq(200)
        response.body.should == comments.to_json
      end
    end

    describe 'all_favoring_posts' do
      it 'should return json format of all the post of given user_id' do
        favored_posts = create_favoring(@user.id)
        get :all_favoring_posts, {:user_id => @user.id} 
        response.body.should == favored_posts.to_json
      end
    end

    describe 'all_following_topics' do
      it 'should return json format of all the topic followed by a given user' do
        followed_topics = create_followship(@user.id)
        get :all_following_topics, {:user_id => @user.id}
        JSON.parse(response.body).should == JSON.parse(followed_topics.to_json)
      end
    end

    describe 'index' do
      it 'should return json format of all users in descendent order' do
        all_user = FactoryGirl.create_list(:user,2) << @user
        get :index
        response.body.should == all_user.sort {|x, y| y.created_at <=> x.created_at}.
          to_json
      end
=begin
      context "with a search term" do
        it "performs a search for matching comment text" do
          get :index, {search: "sandwiches"}
          Sunspot.session.should be_a_search_for(User)
          Sunspot.session.should have_search_params(:fulltext, "sandwiches")
        end
      end
=end
    end

    describe 'show' do
      context 'user_id exist' do
        it 'should return json of a given user(id,username,email,)' do
          get :show, {:id => @user.id}
          response.body.should == {:id => @user.id,
            :username => @user.username,
            :email => @user.email}.to_json
        end
      end
      context 'user_id does not exit' do
        it 'should return 404' do
          FactoryGirl.create_list(:user, 5)
          get :show, {:id => 0}
          response.status.should == 404
        end 
      end
    end

    describe 'update' do
      it 'should return 406 if user_id is not current user' do
        other = FactoryGirl.create(:user)
        put :update, {:id => other.id}.merge!(FactoryGirl.attributes_for(:user))
        response.status.should == 406
      end
      it 'should return success if user_id is curent user' do
        param = {:id => @user.id,
          :email => 'new_email@jhu.edu',
          :password => 'newpassword',
          :password_confirmation => 'newpassword',
          :username => 'new'} 
        put :update, param
        response.status.should == 200
        JSON.parse(response.body)['message'] == 'successful updated'
        u = User.find(@user.id)
        u.email.should == param[:email]
        u.username.should == param[:username]
      end
    end

    describe 'destroy' do
      it 'should return 406 if user_id is not current_usrer' do
        other = FactoryGirl.create(:user)
        delete :destroy, {:id => other.id}
        response.status.should == 406
      end
      it 'should return successful if user_id is current_user' do
        delete :destroy, {:id => @user.id}
        response.status.should == 200
      end
    end

  end
end

