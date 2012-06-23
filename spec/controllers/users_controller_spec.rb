require 'spec_helper'

describe UsersController do
  let(:agent) {FactoryGirl.create(:agent)}
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
end