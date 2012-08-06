FactoryGirl.define do
  factory :offer do
    association :agent, :email => "offer_agent@talentdrivendevelopment.com"
    association :talent, :email => "offer_talent@talentdrivendevelopment.com"
    entity "Some Company"
    description "$100,000 plus a nice chair"
    
    after(:build) {|offer| offer.agent.talents << offer.talent}

    factory :offer_no_after_create do
      after(:build) {|offer| offer.class.skip_callback(:create,:after,:send_offer)}
    end
  end
end
