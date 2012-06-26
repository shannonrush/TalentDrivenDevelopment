FactoryGirl.define do
  factory :agent do
    email "agent@talentdrivendevelopment.com"
    password "password"
    password_confirmation "password"
    confirmed_at Time.zone.now
  end
  factory :talent do
    email "talent@talentdrivendevelopment.com"
    password "password"
    password_confirmation "password"
    confirmed_at Time.zone.now
  end
end