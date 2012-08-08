require "spec_helper"

describe NotificationMailer do
  let (:notification) {FactoryGirl.create(:notification)}
  before(:each) {ActionMailer::Base.deliveries = []}
  describe '#notify' do
    before(:each) do
      NotificationMailer.notify(notification).deliver
      @mail = ActionMailer::Base.deliveries.first
    end
    it 'should send an email to notification talent' do
      @mail['to'].to_s.should match notification.talent.email
    end
    it 'should send an email with the correct subject' do
      @mail['subject'].to_s.should match "#{notification.agent.full_name} Is Available"
    end
  end
end
