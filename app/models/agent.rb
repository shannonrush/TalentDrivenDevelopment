class Agent < User
  has_many :talents
  has_many :agent_badges
  has_many :badges, :through => :agent_badges
  has_many :requests
  has_many :notifications
  has_many :interviews
  has_many :offers

  def available?
    self.talents.count < self.talents_allowed
  end

  def talents_allowed
    points = self.points
    if points < 1
      1
    elsif points.between?(2,5)
      2
    elsif points.between?(6,10)
      3
    else
      5
    end
  end

  protected

  def points
    self.interview_points + self.offer_points + self.badge_points
  end

  def interview_points
    # +1 for each acceptable interview
    # -3 for each unacceptable interview
    # +3 for each accepted interview
    acceptable = Interview.acceptable.for_agent(self).count
    unacceptable = Interview.unacceptable.for_agent(self).count * -3
    accepted = Interview.accepted.for_agent(self).count * 3
    acceptable + unacceptable + accepted
  end

  def offer_points
    # +3 for each acceptable offer
    # -3 for each unacceptable offer
    # +5 for each accepted offer
    acceptable = Offer.acceptable.for_agent(self).count * 3
    unacceptable = Offer.unacceptable.for_agent(self).count * -3
    accepted = Offer.accepted.for_agent(self).count * 5
    acceptable + unacceptable + accepted
  end

  def badge_points
    # +2 for each badge
    self.badges.count * 2
  end
end
