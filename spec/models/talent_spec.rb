require 'spec_helper'

describe Talent do
  describe '#pending_notification_for?' do
    it 'should be true if talent has notification belonging to agent' do
      talent.notifications << Notification.create(agent:agent,talent:talent)
      talent.pending_notification_for?(agent).should be_true
    end
    it 'should be false if talent does not have notification belonging to agent' do
      other_agent = FactoryGirl.create(:agent, :email => "other_agent@talentdrivendevelopment.com")
      talent.notifications << Notification.create(agent:other_agent,talent:talent)
      talent.pending_notification_for?(agent).should be_false

    end
    it 'should be false if talent has no notifications' do
      talent.pending_notification_for?(agent).should be_false
    end
  end
end
