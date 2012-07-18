require 'spec_helper'

describe InterviewsHelper do
  include Devise::TestHelpers
  let(:interview) {FactoryGirl.create(:interview)}
  describe '#unacceptable_class' do
    it 'should return the string unacceptable if interview.unacceptable' do
      interview.acceptable = false
      unacceptable_class(interview).should match "unacceptable"
    end
    it 'should return empty string if interview.acceptable is true' do
      interview.acceptable = true
      unacceptable_class(interview).should be_empty
    end
    it 'should return empty string interview.unacceptable is nil' do
      unacceptable_class(interview).should be_empty
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
    it 'should return the talent name if current user is Agent' do
      sign_in(agent)
      talent_or_agent(interview, agent).should match interview.talent.full_name
    end
    it 'should return the agent name if current user is Talent' do
      sign_in(talent)
      talent_or_agent(interview, talent).should match interview.agent.full_name 
    end
  end
end
