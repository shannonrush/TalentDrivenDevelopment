require 'spec_helper'

describe Offer do
  let(:offer) {FactoryGirl.create(:offer)}
  describe Offer,".accepted" do
    it "should include offers where accepted is true" do
      offer.update_column(:accepted,true)
      Offer.accepted.should include(offer)
    end
    it "should not include offers where accepted is false" do
      offer.update_column(:accepted,false)
      Offer.accepted.should_not include(offer)
    end
    it "should not include offers where accepted is nil" do
      Offer.accepted.should_not include(offer)
    end
  end
  describe Offer,".acceptable" do
    it "should include offers where acceptable is true" do
      offer.update_column(:acceptable,true)
      Offer.acceptable.should include(offer)
    end
    it "should not include offers where acceptable is false" do
      offer.update_column(:acceptable,false)
      Offer.acceptable.should_not include(offer)
    end
    it "should not include offers where acceptable is nil" do
      Offer.acceptable.should_not include(offer)
    end
  end
  describe Offer,".unacceptable" do
    it "should include offers where acceptable is false" do
      offer.update_column(:acceptable,false)
      Offer.unacceptable.should include(offer)
    end
    it "should not include offers where acceptable is true" do
      offer.update_column(:acceptable,true)
      Offer.unacceptable.should_not include(offer)
    end
    it "should not include offers where acceptable is nil" do
      Offer.unacceptable.should_not include(offer)
    end
  end
  describe Offer,".for_agent" do
    it "should include offers belonging to agent" do
      offer.update_column(:agent_id,agent.id)
      Offer.for_agent(agent).should include(offer)
    end
    it "should not include offers not belonging to agent" do
      Offer.for_agent(agent).should_not include(offer)
    end
  end  
  describe 'validations' do
    it 'should be invalid without agent' do
      offer.agent = nil
      offer.should be_invalid
    end
    it 'should be invalid without talent' do
      offer.talent = nil
      offer.should be_invalid
    end
    it 'should be invalid without entity' do
      offer.entity = nil
      offer.should be_invalid
    end
    it 'should be invalid without description' do
      offer.description = nil
      offer.should be_invalid
    end
    it 'should be invalid without acceptable on update' do
      offer.update_attributes(accepted:true)
      offer.should be_invalid
    end
    it 'should be invalid without accepted on update' do
      offer.update_attributes(acceptable:true)
      offer.should be_invalid
    end
  end
end
