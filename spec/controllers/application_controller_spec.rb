require 'spec_helper'

describe ApplicationController do
  describe '#edit_path_for_user' do
    it 'should return agent edit path for Agent' do
      controller.send(:edit_path_for_user,agent).should eql "/agents/#{agent.id}/edit"    
    end
    it 'should return talent edit path for Talent' do
      controller.send(:edit_path_for_user,talent).should eql "/talents/#{talent.id}/edit"    
    end
  end
  describe '#dashboard_path_for_user' do
    it 'should return agent dashboard path for Agent' do
      controller.send(:dashboard_path_for_user,agent).should eql "/agents/#{agent.id}/dashboard"
    end
    it 'should return talent dashboard path for Talent' do
      controller.send(:dashboard_path_for_user,talent).should eql "/talents/#{talent.id}/dashboard"
    end
  end
end
