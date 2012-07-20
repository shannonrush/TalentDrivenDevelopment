module OfferMailerHelper
  def offer_reply(offer)
    if offer.acceptable
      offer.accepted ? "accepted" : "rejected"
    else
      "unacceptable"
    end
  end
end
