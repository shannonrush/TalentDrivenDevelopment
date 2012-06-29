FactoryGirl.define do
  factory :agent do
    email "agent@talentdrivendevelopment.com"
    first_name "Alice"
    last_name "Agent"
    password "password"
    password_confirmation "password"
    confirmed_at Time.zone.now
  end
  factory :talent do
    email "talent@talentdrivendevelopment.com"
    first_name "Terri"
    last_name "Talent"
    password "password"
    password_confirmation "password"
    confirmed_at Time.zone.now
  end
end
