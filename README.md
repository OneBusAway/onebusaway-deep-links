[![Build Status](https://img.shields.io/travis/OneBusAway/onebusaway-deep-links.svg)](https://travis-ci.org/OneBusAway/onebusaway-deep-links)

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

## API Endpoint

[GTFS-RT compliant alerts](https://developers.google.com/transit/gtfs-realtime/#data_format) are available in protobuf format from:

```
http://alerts.onebusaway.org/api/v1/regions/{region_id}/alerts.pb
```

where `region_id` is the region identifier defined in the [OBA Regions API](http://regions.onebusaway.org/regions-v3.json). For instance, Tampa is `0` and Puget Sound is `1`.

A text version of alerts can be viewed by changing the URL's file extension from `pb` to `pbtext`. For instance:

```
http://alerts.onebusaway.org/api/v1/regions/1/alerts.pb
```

can be changed to:

```
http://alerts.onebusaway.org/api/v1/regions/1/alerts.pbtext
```

Append `?test=1` to the URL to view any test feed items that have been created:

```
http://alerts.onebusaway.org/api/v1/regions/1/alerts.pb?test=1
```