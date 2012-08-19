class OfferMailer < ActionMailer::Base
  default from: "\"TDD\"<support@talentdrivendevelopment.com>"

  def offer(offer)
    # sent to offer talent on offers#create
    @offer = offer
    mail(
      to:offer.talent.email,
      subject:"New Offer!"
    )
  end

  def offer_reply(offer)
    # sent to offer agent on offers#update
    @offer = offer
    mail(
      to:offer.agent.email,
      subject:"Offer Reply"
    )
  end

end
