require 'spec_helper'

describe AgentBadge do
  let(:badge) {FactoryGirl.create(:badge)}
  describe 'validations' do
    it 'should not allow agent to have the same badge twice' do
      AgentBadge.create(agent:agent,badge:badge)
      AgentBadge.create(agent:agent,badge:badge).should_not be_valid
    end
  end 
end
