FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "annaPanda#{n}" }
    sequence(:email) { |n| "a#{n}@a" }
    password {"111111"}
    password_confirmation {"111111"}
  end
end