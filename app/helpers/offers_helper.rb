module OffersHelper
  def accepted_text(offer)
    if offer.accepted.nil?
      "No Response"
    else
      offer.accepted ? "Yes" : "No"
    end
  end

  def unacceptable_class(offer)
    offer.acceptable || offer.acceptable.nil? ? nil : "unacceptable"
  end

  def talent_or_agent(offer, current_user)
    current_user.agent? ? "Talent: #{offer.talent.full_name}" : "Agent: #{offer.agent.full_name}"
  end

  def needs_response(offer, current_user)
    offer.talent == current_user && offer.accepted.nil?
  end
end
