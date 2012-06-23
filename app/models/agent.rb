class Agent < User
  has_many :talents
  has_many :agent_badges
  has_many :badges, :through => :agent_badges
end