FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "sample#{n}@example.com" }
    sequence(:name) { |n| "name#{n}" }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
