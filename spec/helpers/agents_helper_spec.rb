require 'spec_helper'

describe AgentsHelper do
  include Devise::TestHelpers
  describe '#show_request' do
    it 'should be true if current user is Talent' do
      sign_in(talent)
      show_request?(talent).should be_true
    end
    it 'should be false if current user is Agent' do
      sign_in(agent)
      show_request?(agent).should be_false
    end
    it 'should be false if no current user' do
      show_request?(nil).should be_false
    end
  end
  describe '#request_by_availability' do
    before(:each) do
      sign_in(talent)
    end
    it 'should return request if agent is available'
    it 'should return unavailable if agent is unavailable' 
  end
end
