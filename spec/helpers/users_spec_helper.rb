require 'spec_helper'

describe UsersHelper do
  describe '#path_for_user' do
    it 'should return agent path for Agent' do
      helper.path_for_user(agent).should eql "/agents/#{agent.id}"
    end
    it 'should return talent path for Talent' do
      helper.path_for_user(talent).should eql "/talents/#{talent.id}"
    end
  end
end
