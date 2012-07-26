class Badge < ActiveRecord::Base
  
  has_many :agent_badges
  has_many :agents, :through => :agent_badges
  
  attr_accessible :name, :description
end
