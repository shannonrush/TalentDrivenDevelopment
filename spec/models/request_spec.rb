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
    it 'should send a new request email to requested Agent' do
      request = FactoryGirl.create(:request)
      mails = ActionMailer::Base.deliveries
      subjects = mails.collect {|m| m['subject'].to_s}
      subjects.should include "#{request.talent.first_name} Requests Representation"
    end 
    it 'should send a new request email to requesting Talent' do
      FactoryGirl.create(:request)
      mails = ActionMailer::Base.deliveries
      subjects = mails.collect {|m| m['subject'].to_s}
      subjects.should include "Confirmation of Request"  
    end
  end
  describe '#make_pending' do
    it 'should set pending true on created request' do 
      request = FactoryGirl.create(:request)
      request.pending.should be_true
    end
  end
  describe '#update_associations' do
    it 'should set requesting talent as belonging to requested agent upon acceptance' do
      request = FactoryGirl.create(:request_no_emails)
      request.update_attributes(accepted:true)
      request.agent.talents.count.should equal 1
    end
    it 'should not set requesting talent as belonging to requested agent upon rejection' do
      request = FactoryGirl.create(:request_no_emails)
      request.update_attributes(accepted:false)
      request.agent.talents.count.should equal 0 
    end
  end
  describe '#send_update_request_emails' do
    it 'should send an email to requested agent'
    it 'should send an email to requesting talent'
  end
  describe '#remove_pending' do
    it 'should set pending flag to false' 
  end
end
