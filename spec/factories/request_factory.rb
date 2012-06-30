FactoryGirl.define do
  factory :request do
    association :agent, email:"req_agent@talentdrivendevelopment.com"
    association :talent, email:"req_talent@talentdrivendevelopment.com"
  end
end

