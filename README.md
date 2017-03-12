# Setup

1. Install RVM (https://rvm.io): `\curl -sSL https://get.rvm.io | bash -s stable`
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

# Features

## Service Alerts

Service alerts involve the following models:

- `AlertFeed` - Represents a single service alert feed. It is primarily designed to consume RSS feeds. This is an STI model; child classes are responsible for knowing how to parse their own feed types. See `KingCountyMetroAlertFeed`.
- `AlertFeedItem` - Represents an item in an `AlertFeed`

Alert feeds are updated from their sources by running `rake update_alert_feeds`. In production, this is managed with the Heroku Scheduler add-on.

### Endpoints

- `GET /regions/:region_id/alert_feeds` - Returns a JSON collection of `AlertFeed` objects.
- `GET /regions/:region_id/alert_feeds/:id` - Returns a JSON collection of `AlertFeedItem` objects for the given `AlertFeed` id. Accepts a `since` parameter formatted as a UTC timestamp.  