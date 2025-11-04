FactoryBot.define do
  sequence :email do |n|
    "someone#{n}@example.com"
  end

  sequence(:password) do |n|
    "12345678#{n}"
  end

  factory :user do
    email
    password
  end
end
