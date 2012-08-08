FactoryGirl.define do
  factory :notification do
    association :agent, email:"notify_agent@talentdrivendevelopment.com"
    association :talent, email:"notify_talent@talentdrivendevelopment.com"
  end
end
