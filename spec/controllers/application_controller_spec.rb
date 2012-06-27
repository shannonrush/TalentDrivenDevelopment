require 'spec_helper'

describe ApplicationController do
  let(:agent) {FactoryGirl.create(:agent)}
  let(:talent) {FactoryGirl.create(:talent)}  
  describe '#other_user_type' do
    it 'should return Agent if current user is Talent' do
      sign_in(talent)
      controller.send(:other_user_type).should equal Agent
    end
    it 'should return Talent if current user is Agent' do
      sign_in(agent)
      controller.send(:other_user_type).should equal Talent
    end
  end
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
