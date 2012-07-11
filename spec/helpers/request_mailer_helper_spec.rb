require "spec_helper"

describe RequestMailerHelper do
  let(:request) {FactoryGirl.create(:request_no_after_create)}
  describe '#reply' do
    it 'should return accepted if request.accepted' do
      request.accepted = true
      reply(request).should match "accepted"
    end
    it 'should return rejected if request.rejected' do
      request.accepted = false
      reply(request).should match "rejected"
    end
  end
end
