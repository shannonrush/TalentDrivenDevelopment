require 'spec_helper'

describe Request do
  before(:each) do
    ActionMailer::Base.deliveries = []
    @request = FactoryGirl.create(:request_no_after_create)
  end
  describe '#send_new_request_emails' do
    it 'should send two emails' do
      @request.send_new_request_emails
      ActionMailer::Base.deliveries.count.should equal 2
    end
  end
  describe '#make_pending' do
    it 'should set pending true on created request' do 
      @request.pending.should_not be_true
      @request.make_pending
      @request.pending.should be_true
    end
  end
  describe '#update_associations' do
    it 'should set requesting talent as belonging to requested agent upon acceptance' do
      @request.update_column(:accepted,true)
      @request.update_associations
      @request.agent.talents.count.should equal 1
    end
    it 'should not set requesting talent as belonging to requested agent upon rejection' do
      @request.update_column(:accepted,false)
      @request.agent.talents.count.should equal 0 
    end
  end
  describe '#send_update_request_emails' do
    it 'should send two emails' do
      @request.send_update_request_emails
      ActionMailer::Base.deliveries.count.should equal 2
    end
  end
  describe '#remove_pending' do
    it 'should set pending flag to false' do
      @request.update_column(:pending,true)
      @request.pending.should be_true
      @request.remove_pending
      @request.pending.should be_false      
    end 
  end
end
