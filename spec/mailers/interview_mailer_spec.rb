require "spec_helper"

describe InterviewMailer do
  let(:interview) {FactoryGirl.create(:interview_no_after_create)}
  before(:each) do
    ActionMailer::Base.deliveries = []
  end
  describe 'interview_offer' do
    it 'should send an email with the correct subject to the interview talent' do
      InterviewMailer.interview_offer(interview).deliver
      ActionMailer::Base.deliveries.count.should equal 1
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match "int_talent@talentdrivendevelopment.com"
      mail['subject'].to_s.should match "Interview Offer"
      mail.body.to_s.should include("Hello #{interview.talent.first_name},")
    end
  end
  describe 'interview_reply' do
    it 'should send an email with the correct subject to the interview agent' do
      InterviewMailer.interview_reply(interview).deliver
      ActionMailer::Base.deliveries.count.should equal 1
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match "int_agent@talentdrivendevelopment.com"
      mail['subject'].to_s.should match "Interview Reply"
      mail.body.to_s.should include("Hello #{interview.agent.first_name},")
    end
  end
end
