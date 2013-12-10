require 'spec_helper'
include Sorcery::TestHelpers::Rails

describe Api::V1::PostsController do
 # test when user not log in
  context 'not login' do
    describe "create" do
      it "should return :unauthorized" do
        post :create, FactoryGirl.attributes_for(:post, user_id: '')
        expect(response.status).to eq(401)
      end
    end
  end

  # test when login
  context 'login' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      expect(response.status).to eq(200)
      login_user(@user)
    end

    describe 'create' do
      it 'should return 422 if user_id not given' do
       post :create, FactoryGirl.attributes_for(:post, user_id: '')
       expect(response.status).to eq(422)
      end
    end
  end


  

end
