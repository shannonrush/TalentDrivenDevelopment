require "spec_helper"

describe RequestMailer do
  let(:request) {FactoryGirl.create(:request_no_emails)}
  before(:each) do
    ActionMailer::Base.deliveries = [] 
  end
  describe '#new_request' do
    it 'should send an email to request agent' do
      RequestMailer.new_request(request).deliver 
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match request.agent.email
    end
    it 'should send an email with the correct subject' do
      RequestMailer.new_request(request).deliver 
      mail = ActionMailer::Base.deliveries.first
      mail['subject'].to_s.should match "#{request.talent.first_name} Requests Representation"      
    end
  end
  describe '#new_request_confirmation' do
    it 'should send an email to requesting talent' do
      RequestMailer.new_request_confirmation(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match request.talent.email
    end
    it 'should send an email  with the correct subject' do
      RequestMailer.new_request_confirmation(request).deliver
      mail = ActionMailer::Base.deliveries.first
      mail['subject'].to_s.should match "Confirmation of Request" 
    end
  end
end
