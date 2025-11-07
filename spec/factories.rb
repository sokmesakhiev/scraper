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

  factory :keyword_file do
    user
    name { Faker::Dessert.flavor }

    transient do
      content { File.read('spec/fixtures/files/keywords.csv') }
      filename { 'keyword.csv' }
      content_type { 'text/csv' }
    end

    after(:build) do |t, evaluator|
      t.original_file.attach(io: StringIO.open(evaluator.content, 'rb'),
                               filename: evaluator.filename,
                               content_type: evaluator.content_type,
                               identify: false)
    end
  end

  factory :keyword do
    keyword_file
    term { Faker::Dessert.flavor }
    total_ads { rand(1..100) }
    total_link { rand(1..100) }
    html_code { Faker::Lorem.sentence }
  end
end
