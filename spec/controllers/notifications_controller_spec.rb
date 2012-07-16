require 'spec_helper'

describe NotificationsController do
  describe '#create' do
    before(:each) do
      sign_in(talent)
    end
    it 'should create a Notification with agent_id from params and talent_id of current_user' do
      post :create,{agent_id:agent.id}
      Notification.where(talent_id:talent.id, agent_id:agent.id).count.should equal 1 
    end
    it 'should redirect to agent ppath with success notice on save' do
      post :create,{agent_id:agent.id}
      response.should redirect_to agent_path(agent)
      flash[:notice].should match "You will be notified!"
    end
    it 'should redirect to current user dashboard path with failure notice if not saved' do
      post :create
      response.should redirect_to talent_dashboard_path(talent)
      flash[:notice].should match "Sorry, something went wrong"
    end
  end
end
