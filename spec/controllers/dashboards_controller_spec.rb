require 'spec_helper'

describe DashboardsController do
  describe '#show' do
    it 'should redirect to sign in if no current user' do
      get :show, user_id:agent.id
      response.should redirect_to(new_user_session_path)
    end
    it 'should redirect to current user dashboard path if trying to view another user' do
      sign_in(talent)
      get :show, user_id:agent.id
      response.should redirect_to(talent_dashboard_path(talent))
    end
    it 'should not redirect if current user is user' do
      sign_in(agent)
      get :show, user_id:agent.id
      response.should_not be_redirect
      response.should be_successful
    end
  end
end
