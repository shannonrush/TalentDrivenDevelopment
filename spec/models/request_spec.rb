require 'spec_helper'

describe Request do
  before(:each) do
    ActionMailer::Base.deliveries = []
    @request = FactoryGirl.create(:request_no_after_create)
  end
  describe 'validations' do
    it 'should require a value for accepted on update' do
      @request.update_attributes(pending:false)
      @request.should_not be_valid
      @request.errors.messages[:accepted].first.should match "choice must be selected"
    end
  end
  describe '#none_outstanding' do
    it 'should not allow a second pending request with agent/talent pair' do
      @request.update_column(:pending,true)
      second_request = Request.new(agent:@request.agent,talent:@request.talent)
      second_request.should_not be_valid
      second_request.errors.messages[:base].first.should match "You already have a request pending for this agent"
    end
  end
end
