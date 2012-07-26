require 'spec_helper'

describe ApplicationHelper do
  include Devise::TestHelpers
  describe '#dashboard_path_for_user' do
    it 'should return agent dashboard path for agent' do
      sign_in(agent)
      helper.dashboard_path_for_user.should match agent_dashboard_path(agent)
    end
    it 'should return talent dashboard path for talent' do
      sign_in(talent)
      helper.dashboard_path_for_user.should match talent_dashboard_path(talent)
    end
  end
  describe '#image_name' do
    it 'should return the name downcased with underscores and .png' do
      image_name("The Name").should match "the_name.png"
    end
  end
end
