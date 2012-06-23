FactoryGirl.define do
  factory :agent do
    email "shannon@talentdrivendevelopment.com"
    password "password"
    password_confirmation "password"
    confirmed_at Time.zone.now
  end
end