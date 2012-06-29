require 'spec_helper'

describe RequestsController do
  describe '#create' do
    before(:each) do
      sign_in(talent)
      post :create, {:request => {:agent_id => agent.id,:talent_id => talent.id,:message=>"Hello!"}}
    end
    it 'should create a request record with the agent id, talent id and pending true and message if provided' do
      Request.count.should equal 1
      Request.where(agent_id:agent.id,talent_id:talent.id,pending:true,message:"Hello!").count.should equal 1
    end
    it 'should redirect to requesting talent dashboard' do
      response.should redirect_to(talent_dashboard_path(talent))
    end
  end
end
