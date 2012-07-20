require "spec_helper"

describe OfferMailer do
  let (:offer) {FactoryGirl.create(:offer_no_after_create)}
  before(:each) {ActionMailer::Base.deliveries = []}
  describe '#offer' do
    it 'should send an email with the correct subject to the offer talent' do
      OfferMailer.offer(offer).deliver
      ActionMailer::Base.deliveries.count.should equal 1
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match "offer_talent@talentdrivendevelopment.com"
      mail['subject'].to_s.should match "New Offer!"
      mail.body.to_s.should include("Hello #{offer.talent.first_name},")
    end
  end
  describe '#offer_reply' do
    it 'should send an email with the correct subject to the offer agent' do
      OfferMailer.offer_reply(offer).deliver
      ActionMailer::Base.deliveries.count.should equal 1
      mail = ActionMailer::Base.deliveries.first
      mail['to'].to_s.should match "offer_agent@talentdrivendevelopment.com"
      mail['subject'].to_s.should match "Offer Reply"
      mail.body.to_s.should include("Hello #{offer.agent.first_name},")
    end
  end
end
