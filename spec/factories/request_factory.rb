FactoryGirl.define do
  factory :request do
    association :agent, email:"req_agent@talentdrivendevelopment.com"
    association :talent, email:"req_talent@talentdrivendevelopment.com"

    factory :request_no_emails do
      after(:create) {|request|request.class.skip_callback(:create,:after,:send_new_request_emails)} 
    end
  end
end

