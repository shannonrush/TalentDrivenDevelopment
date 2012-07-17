require "spec_helper"

describe InterviewMailer do
  let(:interview) {FactoryGirl.create(:interview_no_after_create)}
  describe 'interview_offer' do
    it 'should send an email with the correct subject to the interview talent' do
      ActionMailer::Base.deliveries = []
      InterviewMailer.interview_offer(interview).deliver
      ActionMailer::Base.deliveries.count.should equal 1
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match "int_talent@talentdrivendevelopment.com"
      mail['subject'].to_s.should match "Interview Offer"
      mail.body.to_s.should include("Hello #{interview.talent.first_name},")
    end
  end
end
