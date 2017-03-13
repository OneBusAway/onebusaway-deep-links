source 'https://rubygems.org'

ruby '2.3.3'

# gem install nokogiri -v '1.6.8.1' -- --use-system-libraries --with-xml2-include=/usr/local/opt/libxml2/include/libxml2

gem 'rails', '~> 5.0.2'
gem 'pg', '~>0.19.0'
gem 'puma', '~> 3.0'

gem 'airbrake', '~>5.6.1'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# API client builder
gem 'rest-client', '~> 2.0'

gem 'dotenv', '~> 2.1.1'
gem 'awesome_print', '~> 1.7.0'
gem 'feedjira', '~> 2.1.2'
gem 'nokogiri', '~> 1.6.8.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~>3.5.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'vcr', '~> 3.0.3'
  gem 'webmock', '~> 2.3.2'
end