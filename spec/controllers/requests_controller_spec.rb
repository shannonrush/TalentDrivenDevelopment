require 'spec_helper'

describe RequestsController do
  let(:other_agent) {FactoryGirl.create(:agent, email: "other@talentdrivendevelopment.com")}
  let(:request) {FactoryGirl.create(:request)}
  let(:the_request) {FactoryGirl.create(:request)}
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
  describe '#check_authorization' do
    it 'should redirect to sign in if no current user' do
      get :edit
      response.should redirect_to(new_user_session_path)
    end 
    it 'should redirect current user to dashboard path if not requested agent' do
      sign_in(other_agent)
      get :edit, id:request
      response.should redirect_to(agent_dashboard_path(other_agent))
    end 
    it 'should not redirect if current user is requested agent' do
      sign_in(request.agent)
      get :edit, id:request
      response.should_not be_redirect
      response.should be_successful
    end
  end
  describe '#update' do
    before(:each) do
      sign_in(request.agent)
    end
    it 'should render edit if no accepted value in params' do
      put :update, id:request
      response.should render_template("edit")
    end
    it 'should set request accepted flag to true upon acceptance' do
      put :update, {id:request,"request"=>{accepted:true}}
      request.reload
      request.accepted.should be_true  
    end
    it 'should not set request accepted flag to false upon rejection' do
      put :update, {id:request,"request"=>{accepted:false}}
      request.reload
      request.accepted.should be_false
    end
    it 'should update associations upon acceptance' do
      put :update, {id:request,"request"=>{accepted:true}}
      request.agent.talents.count.should equal 1
    end
    it 'should not update associations upon rejection' do
      put :update, {id:request,"request"=>{accepted:false}}
      request.agent.talents.count.should equal 0
    end
    it 'should send two emails' do
      ActionMailer::Base.deliveries = []
      put :update, {id:request,"request"=>{accepted:true}}
      ActionMailer::Base.deliveries.count.should equal 2
    end
    it 'should set pending flag to false' do
      request.pending.should be_true
      put :update, {id:request,"request"=>{accepted:true}}
      request.reload
      request.pending.should be_false
    end
    it 'should redirect to agent dashboard' do
      put :update, {id:request,"request"=>{accepted:true}}
      response.should redirect_to(agent_dashboard_path(request.agent))
    end 
  end
end
