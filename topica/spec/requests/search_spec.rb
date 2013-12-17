require 'spec_helper'
require 'factory_helpers'

include Sorcery::Controller::InstanceMethods
RSpec.configure do |c|
    c.include FactoryHelpers
end
  describe 'search_all', search: true do
    before(:each) do
      init_integration_test  
    end
 
    context 'login' do
      before(:each) do
        post '/api/v1/login', :email => 'username1email@example.com',
                              :password => 'secret'
      end
      it 'should blabla' do
        get '/search', {:search_string => "fenghuan"}
        response.status.should == 200
      end
    end

end #end login
