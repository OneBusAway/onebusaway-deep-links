FactoryBot.define do
  factory :admin do
    name { "Admin" }
    email { "admin@example.com" }
    password { "password" }
    region
  end

  factory :question do
    survey
  end

  factory :region do
    sequence(:region_identifier) { |n| n }
    sequence(:api_url) { |n| "https://example.org/#{n}/" }
    sequence(:web_url) { |n| "https://example.com/#{n}/" }
    name { "Example Region" }
  end

  factory :study do
    name { "Study" }
    description { "Study Description" }
    region
  end

  factory :survey do
    name { "Survey Name" }
    study
    available { false }
    start_date { Time.current + 1.day }
    end_date { Time.current + 2.day }

    trait :invalid_end_date_before_start_date do
      start_date { Time.current + 2.days }
      end_date { Time.current + 1.day }
    end
  end

  factory :survey_response do
    survey
    sequence(:user_identifier) { |n| "user_identifier_#{n}" }
  end
end
