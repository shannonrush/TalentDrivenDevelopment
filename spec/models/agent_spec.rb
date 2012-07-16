require 'spec_helper'

describe Agent do
  describe '#available?' do
    it 'should return true when talents allowed > talents'
    it 'should return false when talents allows <= talents' 
  end
  describe '#talents_allowed' do
    it 'should return 1 if point total is <= 1'
    it 'should return 2 if point total is 2-5'
    it 'should return 3 if point total is 6-10'
    it 'should return 5 if point total is > 10'
  end
end
