require 'spec_helper'

describe Request do
  #let(:request){FactoryGirl.create(:request)}
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
end
