FactoryBot.define do
  factory :tweet do
    text {"hello"}
    association :user
  end
end