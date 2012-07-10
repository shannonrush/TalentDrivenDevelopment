require 'spec_helper'

describe User do
  describe '#full_name' do
    it 'should return user first name and last name' do
      agent.full_name.should match "Alice Agent"  
    end
  end
end
