require 'spec_helper'

describe Agent do
  describe '#available?' do
    it 'should return true when talents allowed > talents' do
      agent.available?.should be_true 
    end
    it 'should return false when talents allows <= talents' do
      agent.talents << talent
      agent.available?.should be_false
    end 
  end
  describe '#talents_allowed' do
    it 'should return 1 if point total is <= 1' do
      agent.talents_allowed.should equal 1
    end
    it 'should return 2 if point total is 2-5' do
      FactoryGirl.create(:interview, accepted:true, agent_id:agent.id)
      agent.talents_allowed.should equal 2
    end
    it 'should return 3 if point total is 6-10' do
      FactoryGirl.create(:interview, accepted:true, agent_id:agent.id)
      FactoryGirl.create(:offer, accepted:true, agent_id:agent.id)
      agent.talents_allowed.should equal 3   
    end
    it 'should return 5 if point total is > 10' do
      FactoryGirl.create(:interview, accepted:true, agent_id:agent.id)
      FactoryGirl.create(:offer, accepted:true, agent_id:agent.id)
      agent.badges << FactoryGirl.create(:badge)
      agent.badges << FactoryGirl.create(:badge, name:"Badge 2")
      agent.talents_allowed.should equal 5      
    end
  end
end
