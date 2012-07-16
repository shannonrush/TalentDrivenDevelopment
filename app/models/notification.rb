class Notification < ActiveRecord::Base
  attr_accessible :agent_id,:agent,:talent_id,:talent

  belongs_to :agent
  belongs_to :talent

  validates_presence_of :agent, :talent
end
