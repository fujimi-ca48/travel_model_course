FactoryBot.define do
  factory :recommended_spot do
    sequence(:name) { |n| "タイトル#{n}" }
    address { '東京都' }
    img { 'sample.jpg' }
    association :user
  end
end
