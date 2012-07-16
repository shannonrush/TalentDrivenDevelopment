class Agent < User
  has_many :talents
  has_many :agent_badges
  has_many :badges, :through => :agent_badges
  has_many :requests
  has_many :notifications

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
    #self.interview_points + self.offer_points + self.badge_points
    0 # TODO: placeholder until other points implemented
  end

  def interview_points
  end

  def offer_points
  end

  def badge_points
  end
end
