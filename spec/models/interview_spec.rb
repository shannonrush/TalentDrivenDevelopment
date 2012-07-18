require 'spec_helper'

describe Interview do
  let (:interview) {FactoryGirl.create(:interview)}
  describe 'validations' do
    it 'should be invalid without agent_id' do
      interview.agent_id = nil
      interview.should be_invalid
    end
    it 'should be invalid without talent_id' do
      interview.talent_id = nil
      interview.should be_invalid
    end
    it 'should be invalid without entity' do
      interview.entity = nil
      interview.should be_invalid
    end
    it 'should be invalid without description' do
      interview.description = nil
      interview.should be_invalid
    end
    it 'should be invalid without acceptable or accepted on update' do
      interview.update_attributes(agent_id:1)
      interview.should be_invalid
    end
  end  
end
