require 'spec_helper'

describe Notification do
  let(:notification) {FactoryGirl.create(:notification)}
  describe 'validations' do
    it 'should be invalid without agent' do
      notification.update_column(:agent_id, nil)
      notification.should_not be_valid
    end
    it 'should be invalid without talent' do
      notification.update_column(:talent_id, nil)
      notification.should_not be_valid
    end
    it 'should be valid with agent and talent' do
      notification.agent_id.should_not be_nil
      notification.talent_id.should_not be_nil
      notification.should be_valid
    end
  end
  describe '.notify' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      @notification = notification
      Notification.notify
    end
    it 'should send one email' do
      ActionMailer::Base.deliveries.count.should equal 1
    end
    it 'should delete notification' do
      Notification.count.should equal 0
    end
  end
end
