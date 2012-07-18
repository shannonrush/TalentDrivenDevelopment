require 'spec_helper'

describe User do
  describe '#full_name' do
    it 'should return user first name and last name' do
      agent.full_name.should match "Alice Agent"  
    end
  end
  describe '#agent?' do
    it 'should return true if user is type Agent' do
      agent.agent?.should be_true
    end
    it 'should return false if user is type Talent' do
      talent.agent?.should be_false
    end
  end
  describe '#talent?' do
    it 'should return false if user is type Agent' do
      agent.talent?.should be_false
    end
    it 'should return true if user is type Talent' do
      talent.talent?.should be_true
    end
  end
end
