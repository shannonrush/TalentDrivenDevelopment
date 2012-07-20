require 'spec_helper'

describe OffersHelper do
  include Devise::TestHelpers
  let(:offer) {FactoryGirl.create(:offer)}
  describe '#unacceptable_class' do
    it 'should return the string unacceptable if offer.unacceptable' do
      offer.acceptable = false
      unacceptable_class(offer).should match "unacceptable"
    end
    it 'should return nil if offer.acceptable is true' do
      offer.acceptable = true
      unacceptable_class(offer).should be_nil
    end
    it 'should return nil offer.unacceptable is nil' do
      unacceptable_class(offer).should be_nil
    end
  end
  describe '#accepted_text' do
    it 'should return the string Yes if offer is accepted' do
      offer.accepted = true
      accepted_text(offer).should match "Yes"
    end
    it 'should return the string No if offer not accepted' do
      offer.accepted = false
      accepted_text(offer).should match "No"
    end
    it 'should return the string No Response if offer.accepted is nil' do
      accepted_text(offer).should match "No Response"
    end
  end
  describe '#talent_or_agent' do
    it 'should return the Talent: and talent name if current user is Agent' do
      sign_in(agent)
      talent_or_agent(offer, agent).should match "Talent: #{offer.talent.full_name}"
    end
    it 'should return Agent: and the agent name if current user is Talent' do
      sign_in(talent)
      talent_or_agent(offer, talent).should match "Agent: #{offer.agent.full_name}" 
    end
  end
  describe '#needs_response' do
    it 'should return true if current user is the offer talent and offer has not been accepted or rejected' do
      needs_response(offer, offer.talent).should be_true
    end
    it 'should return false if current user is not offer talent' do
      needs_response(offer, offer.agent).should be_false
    end
    it 'should return false if current user is offer talent and offer has been accepted' do
      offer.accepted = true
      needs_response(offer, offer.talent).should be_false
    end
    it 'should return false if current user is offer talent and offer has been rejected' do
      offer.accepted = false
      needs_response(offer, offer.talent).should be_false
    end
  end
end
