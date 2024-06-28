RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  factory :admin do
    name { "Admin" }
    email { "admin@example.com" }
    password { "password" }
    region
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

  factory :study_invite do
    name { "Study Invite" }
    study
    available { false }
  end

  factory :survey_question do
    study_invite
  end
end