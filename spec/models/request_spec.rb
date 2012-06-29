require 'spec_helper'

describe Request do
  describe '#send_new_request_emails' do
    before(:each) do
      ActionMailer::Base.deliveries = []
    end
    it 'should send two emails' do
      FactoryGirl.create(:request)
      mails = ActionMailer::Base.deliveries
      mails.count.should == 2
    end
    pending 'should send a new request email to requested Agent' do
      Request.create(agent_id:agent.id,talent_id:talent.id)
      mails = ActionMailer::Base.deliveries
      mails.find(subject:"#{talent.first_name} Requests Representation").count.should == 1
    end 
    pending 'should send a new request email to requesting Talent' do
      Request.create(agent_id:agent.id,talent_id:talent.id)
      mails = ActionMailer::Base.deliveries
      mails.find(subject:"Confirmation of Request").count.should == 1 
    end
  end
  describe '#make_pending' do
    it 'should set pending true on created request' do 
      request = Request.create(agent_id:agent.id,talent_id:talent.id)
      request.pending.should be_true
    end
  end
end
