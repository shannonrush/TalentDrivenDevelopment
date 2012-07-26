require 'spec_helper'

describe InterviewsController do
  let(:interview) {FactoryGirl.create(:interview)}
  describe '#new' do
    it 'should redirect to sign in if no current user' do
      get :new 
      response.should redirect_to new_user_session_path
    end
  end
  describe '#create' do
    before(:each) do
      sign_in(agent)
    end
    it 'should redirect to sign in if no current user' do
      sign_out(agent)
      post :create,{:interview => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should redirect_to new_user_session_path     
    end
    it 'should create an interview' do
      post :create,{:interview => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      Interview.count.should equal 1
    end
    it 'should send one email' do
      ActionMailer::Base.deliveries = []
      post :create,{:interview => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      ActionMailer::Base.deliveries.count.should equal 1
    end
    it 'should redirect to interviews_path with success notice if saved' do
      post :create,{:interview => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should redirect_to interviews_path
      flash[:notice].should match "Interview interview sent!"
    end
    it 'should render new if invalid' do
      post :create,{:interview => {agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should render_template("new")
    end
  end
  describe '#index' do
    it 'should redirect to sign in if no current user' do
      get :index 
      response.should redirect_to new_user_session_path
    end 
  end
  describe '#edit' do
    it 'should redirect to sign in if no current user' do
      get :edit
      response.should redirect_to new_user_session_path
    end
    it 'should redirect to user dashboard if user is not interview talent' do
      other_talent = FactoryGirl.create(:talent, :email => "other@talentdrivendevelopment.com")
      sign_in(other_talent)
      get :edit, id:interview.id
      response.should redirect_to talent_dashboard_path(other_talent)
      flash[:notice].should match "This does not appear to be your interview. Please try again."
    end
    it 'should redirect to user dashboard if interview has already been updated' do
      sign_in(interview.talent)
      interview.update_column(:acceptable,true)
      interview.update_column(:accepted,true)
      get :edit, id:interview.id
      response.should redirect_to talent_dashboard_path(interview.talent)
      flash[:notice].should match "You have already responded to this interview."  
    end
    it 'should not redirect if interview has not been updated' do
      sign_in(interview.talent)
      get :edit, id:interview.id
      response.should_not be_redirect 
    end
  end
  describe '#update' do
    it 'should redirect to sign in if no current user' do
      put :update 
      response.should redirect_to new_user_session_path
    end 
    it 'should redirect to user dashboard if user is not interview talent' do
      other_talent = FactoryGirl.create(:talent, :email => "other@talentdrivendevelopment.com")
      sign_in(other_talent)
      put :update,id:interview.id
      response.should redirect_to talent_dashboard_path(other_talent)
      flash[:notice].should match "This does not appear to be your interview. Please try again."
    end
    it 'should redirect to user dashboard if interview has already been updated' do
      sign_in(interview.talent)
      interview.update_column(:acceptable,true)
      interview.update_column(:accepted,true)
      put :update, id:interview.id
      response.should redirect_to talent_dashboard_path(interview.talent)
      flash[:notice].should match "You have already responded to this interview."  
    end
    it 'should not redirect if interview has not been updated' do
      sign_in(interview.talent)
      put :update, id:interview.id
      response.should_not be_redirect 
    end
    it 'should update acceptable and accepted' do
      sign_in(interview.talent)
      put :update,id:interview.id,interview:{accepted:true,acceptable:true}
      interview.reload
      interview.acceptable.should_not be_nil
      interview.accepted.should_not be_nil
    end
    it 'should send one email' do
      ActionMailer::Base.deliveries = []
      interview = FactoryGirl.create(:interview_no_after_create)
      sign_in(interview.talent)
      put :update,id:interview.id,interview:{accepted:true,acceptable:true}
      ActionMailer::Base.deliveries.count.should equal 1
    end
    it 'should reward Interview Wonder badge to agent if interview is fifth accepted interview' do
      sign_in(interview.talent)
      4.times {interview.agent.interviews << FactoryGirl.create(:interview,talent:talent, agent:interview.agent, acceptable:true, accepted:true)}
      put :update,id:interview.id,interview:{accepted:true,acceptable:true}
      interview.reload
      interview.agent.badges.should include(Badge.find_by_name("Interview Wonder"))    
    end
    it 'should redirect to talent dashboard path upon successful update' do
      sign_in(interview.talent)
      put :update,id:interview.id,interview:{accepted:true,acceptable:true}
      response.should redirect_to talent_dashboard_path(interview.talent)
      flash[:notice].should match "Your interview has been updated and your agent has been notified"
    end
    it 'should render edit if interview is invalid' do
      sign_in(interview.talent)
      put :update,id:interview.id,interview:{accepted:true}
      response.should render_template("edit")
    end
  end
end
