require 'spec_helper'

describe InterviewsController do
  describe '#create' do
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
      flash[:notice].should match "Interview offer sent!"
    end
    it 'should render new if invalid' do
      post :create,{:interview => {agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should render_template("new")
    end
  end
end
