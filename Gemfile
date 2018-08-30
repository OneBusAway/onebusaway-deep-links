source 'https://rubygems.org'

ruby '2.5.0'

gem 'rails', '~> 5.2.1'
gem 'pg', '~>1.0.0'
gem 'puma', '~> 3.11.4'
gem 'bootsnap', require: false

gem 'airbrake', '~>7.3.4'

gem 'hamlit', '~>2.8.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jbuilder', '~> 2.6'
gem 'zooplankton', '~>1.3.0'

# Protocol Buffers
# https://github.com/codekitchen/ruby-protocol-buffers
gem 'ruby-protocol-buffers', '~>1.6.1'
gem 'varint', '~>0.1.1'

# API client builder
gem 'rest-client', '~> 2.0'

gem 'dotenv', '~> 2.1.1'
gem 'awesome_print', '~> 1.7.0'
gem 'feedjira', '~> 2.1.2'

gem 'bcrypt', '~> 3.1.12'
gem 'strip_attributes', '~>1.8.0'

# gem install nokogiri -v '1.8.4' -- --use-system-libraries --with-xml2-include=/usr/local/opt/libxml2/include/libxml2
gem 'nokogiri', '~> 1.8.4'

gem 'pr_geohash', '~>1.0.0'

gem 'dalli', '~>2.7.8'

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
  gem 'vcr', '~> 4.0.0'
  gem 'webmock', '~> 2.3.2'
  gem 'simplecov', require: false
end