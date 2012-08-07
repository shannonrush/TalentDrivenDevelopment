require 'spec_helper'

describe Interview do
  let (:interview) {FactoryGirl.create(:interview)}
  describe Interview,".accepted" do
    it "should include interviews where accepted is true" do
      interview.update_column(:accepted,true)
      Interview.accepted.should include(interview)
    end
    it "should not include interviews where accepted is false" do
      interview.update_column(:accepted,false)
      Interview.accepted.should_not include(interview)
    end
    it "should not include interviews where accepted is nil" do
      Interview.accepted.should_not include(interview)
    end
  end
  describe Interview,".acceptable" do
    it "should include interviews where acceptable is true" do
      interview.update_column(:acceptable,true)
      Interview.acceptable.should include(interview)
    end
    it "should not include interviews where acceptable is false" do
      interview.update_column(:acceptable,false)
      Interview.acceptable.should_not include(interview)
    end
    it "should not include interviews where acceptable is nil" do
      Interview.acceptable.should_not include(interview)
    end
  end
  describe Interview,".unacceptable" do
    it "should include interviews where acceptable is false" do
      interview.update_column(:acceptable,false)
      Interview.unacceptable.should include(interview)
    end
    it "should not include interviews where acceptable is true" do
      interview.update_column(:acceptable,true)
      Interview.unacceptable.should_not include(interview)
    end
    it "should not include interviews where acceptable is nil" do
      Interview.unacceptable.should_not include(interview)
    end
  end
  describe Interview,".for_agent" do
    it "should include interviews belonging to agent" do
      interview.update_column(:agent_id,agent.id)
      Interview.for_agent(agent).should include(interview)
    end
    it "should not include interviews not belonging to agent" do
      Interview.for_agent(agent).should_not include(interview)
    end
  end  
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
