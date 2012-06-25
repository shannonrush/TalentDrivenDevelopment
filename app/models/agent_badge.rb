class AgentBadge < ActiveRecord::Base
  belongs_to :agent
  belongs_to :badge
end
