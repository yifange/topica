require 'spec_helper'
require 'factory_helpers'

include Sorcery::Controller::InstanceMethods
RSpec.configure do |c|
    c.include FactoryHelpers
end
describe 'search_all', search: true do
    before(:each) do
      # we stub out se
      Sunspot.session = Sunspot.session.original_session
      init_integration_test #from factory_helpers 
    end
 
    context 'login' do
      before(:each) do
        post '/api/v1/login', :email => 'username1email@example.com',
                              :password => 'secret'
        JSON.parse(response.body)["ok"].should == true
      end
      it 'should blabla' do
        get '/api/v1/search', {:search_string => "*"}
        debugger
        response.status.should == 200
      end
    end #end login

end 
