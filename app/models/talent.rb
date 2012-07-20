class Talent < User
  belongs_to :agent
  has_many :requests
  has_many :notifications
  has_many :interviews
  has_many :offers

  def pending_notification_for?(agent)
    self.notifications.collect{|n|n.agent}.include?(agent)
  end
end

