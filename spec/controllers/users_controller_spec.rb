require 'spec_helper'

describe UsersController do
  let(:other_agent) {FactoryGirl.create(:agent, email: "shannonmrush@gmail.com")}
  describe '#check_authorization' do
    it 'should redirect to sign in if no current user' do
      get :edit
      response.should redirect_to(new_user_session_path)
    end 
    it 'should redirect to current user edit path if trying to edit another user' do
      sign_in(agent)
      get :edit, id:other_agent
      response.should redirect_to(edit_agent_path(agent))
    end
    it 'should not redirect if current user is user' do
      sign_in(agent)
      get :edit, id:agent
      response.should_not be_redirect
      response.should be_successful
    end
  end
  describe '#update' do
    it 'should redirect agent to agent dashboard path upon update' do
      sign_in(agent)
      put :update, {id:agent.id}
      response.should redirect_to(agent_dashboard_path(agent))
    end
    it 'should redirect talent to talent dashboard path upon update' do
      sign_in(talent)
      put :update, {id:talent.id}
      response.should redirect_to(talent_dashboard_path(talent))
    end
  end
  describe '#show' do
    it 'should redirect to correct path if path is incorrect user type' do
      get :show, :id => agent.id
      request.stub!(:path).and_return("/talents/#{agent.id}")
      response.should redirect_to(agent_path(agent))
    end
  end
end
