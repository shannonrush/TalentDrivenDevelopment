FactoryGirl.define do
  factory :request do
    association(:agent)
    association(:talent)
  end
end

