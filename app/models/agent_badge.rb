class AgentBadge < ActiveRecord::Base
  belongs_to :agent
  belongs_to :badge

  validates_uniqueness_of :badge_id, :scope => [:agent_id]

  attr_accessible :agent, :badge
end
