class Notification < ActiveRecord::Base
  attr_accessible :agent_id,:agent,:talent_id,:talent

  belongs_to :agent
  belongs_to :talent

  validates_presence_of :agent, :talent

  def self.notify
    notifications = Notification.all.collect {|n| n if n.agent.available?}
    notifications.each do |n| 
      NotificationMailer.notify(n).deliver
      n.delete
    end
  end
end
