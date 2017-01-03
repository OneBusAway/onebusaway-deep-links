# Setup

1. Install RVM (https://rvm.io)
2. Install Postgresql. I like https://postgresapp.com for macOS.
2. Clone the repo
3. cd into the directory where you cloned the repo and agree to whatever RVM says
4. `gem install bundler`
5. `bundle install`
6. `rake db:create`
7. `rake db:schema:load`
8. `rake db:seed`
9. `rails s`
10. `open http://localhost:3000`
