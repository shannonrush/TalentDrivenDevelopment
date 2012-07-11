require "spec_helper"

describe RequestMailer do
  let(:request) {FactoryGirl.create(:request_no_after_create)}
  before(:each) do
    ActionMailer::Base.deliveries = [] 
  end
  describe '#new_request' do
    before(:each) do
      RequestMailer.new_request(request).deliver 
      @mail = ActionMailer::Base.deliveries.first
    end
    it 'should send an email to request agent' do
      @mail['to'].to_s.should match request.agent.email
    end
    it 'should send an email with the correct subject' do
      @mail['subject'].to_s.should match "#{request.talent.first_name} Requests Representation"      
    end
  end
  describe '#new_request_confirmation' do
    before(:each) do
      RequestMailer.new_request_confirmation(request).deliver
      @mail = ActionMailer::Base.deliveries.first 
    end
    it 'should send an email to requesting talent' do
      @mail['to'].to_s.should match request.talent.email
    end
    it 'should send an email  with the correct subject' do
      @mail['subject'].to_s.should match "Confirmation of Request" 
    end
  end
  describe '#request_reply' do
    it 'should send an email to request talent' do
      RequestMailer.request_reply(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match request.talent.email 
    end
    it 'should send an email with the correct subject' do
      RequestMailer.request_reply(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail['subject'].to_s.should match "Your Request For Representation"
    end
    it 'should send an email with accepted body if accepted' do
      request.accepted = true
      RequestMailer.request_reply(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail.body.to_s.should include("Good news! #{request.agent.full_name} is now your talent agent!")
    end
    it 'should send an email with rejected body if rejected' do
      request.accepted = false
      RequestMailer.request_reply(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail.body.to_s.should include("Unfortunately #{request.agent.full_name} has decided they are not a good fit to represent you at this time.")
    end
  end
  describe 'request_reply_confirmation' do
    it 'should send an email to request agent' do
      RequestMailer.request_reply_confirmation(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match request.agent.email
    end
    it 'should send an email with the correct subject' do
      RequestMailer.request_reply_confirmation(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail['subject'].to_s.should match "Your Reply Has Been Received"
    end
    it 'should send an email with accepted body if accepted' do 
      request.accepted = true
      RequestMailer.request_reply_confirmation(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail.body.to_s.should include("We let #{request.talent.full_name} know you've accepted and are now their talent agent!")
    end
    it 'should send an email with rejected body if rejected' do
      request.accepted = false
      RequestMailer.request_reply_confirmation(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail.body.to_s.should include("We let #{request.talent.full_name} know you've decided against representing them at this time.")
    end
  end
end
