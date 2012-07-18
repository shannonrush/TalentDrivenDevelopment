require 'spec_helper'

describe InterviewMailerHelper do
  let(:interview) {FactoryGirl.create(:interview)}
  describe '#interview_reply' do
    it 'should return unacceptable if interview not acceptable' do
      interview.acceptable = false
      interview_reply(interview).should match "unacceptable"
    end
    it 'should return accepted if interview acceptable and accepted' do
      interview.acceptable = true
      interview.accepted = true
      interview_reply(interview).should match "accepted"
    end
    it 'should return rejected if interview acceptable and not accepted' do
      interview.acceptable = true
      interview.accepted = false
      interview_reply(interview).should match "rejected"
    end
  end
end
