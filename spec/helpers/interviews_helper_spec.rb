require 'spec_helper'

describe InterviewsHelper do
  include Devise::TestHelpers
  let(:interview) {FactoryGirl.create(:interview)}
  describe '#unacceptable_class' do
    it 'should return the string unacceptable if interview.unacceptable' do
      interview.acceptable = false
      unacceptable_class(interview).should match "unacceptable"
    end
    it 'should return nil if interview.acceptable is true' do
      interview.acceptable = true
      unacceptable_class(interview).should be_nil
    end
    it 'should return nil interview.unacceptable is nil' do
      unacceptable_class(interview).should be_nil
    end
  end
  describe '#accepted_text' do
    it 'should return the string Yes if interview is accepted' do
      interview.accepted = true
      accepted_text(interview).should match "Yes"
    end
    it 'should return the string No if interview not accepted' do
      interview.accepted = false
      accepted_text(interview).should match "No"
    end
    it 'should return the string No Response if interview.accepted is nil' do
      accepted_text(interview).should match "No Response"
    end
  end
  describe '#talent_or_agent' do
    it 'should return the Talent: and talent name if current user is Agent' do
      sign_in(agent)
      talent_or_agent(interview, agent).should match "Talent: #{interview.talent.full_name}"
    end
    it 'should return Agent: and the agent name if current user is Talent' do
      sign_in(talent)
      talent_or_agent(interview, talent).should match "Agent: #{interview.agent.full_name}" 
    end
  end
  describe '#needs_response' do
    it 'should return true if current user is the interview talent and interview has not been accepted or rejected' do
      needs_response(interview, interview.talent).should be_true
    end
    it 'should return false if current user is not interview talent' do
      needs_response(interview, interview.agent).should be_false
    end
    it 'should return false if current user is interview talent and interview has been accepted' do
      interview.accepted = true
      needs_response(interview, interview.talent).should be_false
    end
    it 'should return false if current user is interview talent and interview has been rejected' do
      interview.accepted = false
      needs_response(interview, interview.talent).should be_false
    end
  end
end
