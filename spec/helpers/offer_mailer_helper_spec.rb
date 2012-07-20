require 'spec_helper'

describe OfferMailerHelper do
  let(:offer) {FactoryGirl.create(:offer)}
  describe '#offer_reply' do
    it 'should return unaccepted if offer not acceptable' do
      offer.acceptable = false
      offer_reply(offer).should match "unacceptable"
    end
    it 'should return accepted if interview acceptable and accepted' do
      offer.acceptable = true
      offer.accepted = true
      offer_reply(offer).should match "accepted"
    end
    it 'should return rejected if interview acceptable and not accepted' do
      offer.acceptable = true
      offer.accepted = false
      offer_reply(offer).should match "rejected"
    end
  end
end

