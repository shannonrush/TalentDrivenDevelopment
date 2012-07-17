FactoryGirl.define do
  factory :interview do
    association :agent, :email => "int_agent@talentdrivendevelopment.com"
    association :talent, :email => "int_talent@talentdrivendevelopment.com"
    entity "Some Startup"
    description "This is a great job with all of your skills"

    factory :interview_no_after_create do
      after(:build) {|interview| interview.class.skip_callback(:create,:after,:send_interview_offer)}
    end
  end
end
