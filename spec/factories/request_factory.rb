FactoryGirl.define do
  factory :request do
    association :agent, email:"req_agent@talentdrivendevelopment.com"
    association :talent, email:"req_talent@talentdrivendevelopment.com"

    factory :request_no_after_create do
      after(:build) {|request|request.class.skip_callback(:create,:after,:send_new_request_emails)} 
      after(:build) {|request|request.class.skip_callback(:create,:after,:make_pending)} 
    end
  end
end

