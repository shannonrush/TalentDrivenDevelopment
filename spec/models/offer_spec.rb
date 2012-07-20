require 'spec_helper'

describe Offer do
  let(:offer) {FactoryGirl.create(:offer)}
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
