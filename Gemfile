source "https://rubygems.org"

ruby "3.3.0"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "redis", ">= 4.0.1"
gem "sentry-rails"
gem "sentry-ruby"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem 'feedjira', '~> 3.2', '>= 3.2.3'
gem 'haml', '~> 6.3'
gem 'jsonb_accessor', '~> 1.4'
gem 'mailgun-ruby', '~>1.2.14'
gem 'pr_geohash', '~>1.0.0'
gem 'rest-client', '~> 2.1'
gem 'ruby-protocol-buffers', '~>1.6.1' # https://github.com/codekitchen/ruby-protocol-buffers
gem 'sidekiq', '~>7.2.4'
gem 'store_model', '~> 3.0', '>= 3.0.2'
gem 'stripe', '~>11.3'
gem 'varint', '~>0.1.1' # needed for protobuf
gem 'view_component', '~> 3.12', '>= 3.12.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug"
  gem "rspec-rails", '~>6.1.2'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'factory_bot_rails', '~>6.4.3'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem 'simplecov'
  gem "vcr", '~>6.2.0'
  gem 'webmock', '~>3.23.1'
  gem 'rails-controller-testing'
end
