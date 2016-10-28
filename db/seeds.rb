# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

begin
  Region.create!({
    region_identifier: 0,
    api_url: 'http://api.tampa.onebusaway.org/api/',
    web_url: 'http://tampa.onebusaway.org/',
    name: 'Tampa'
  })
rescue
end

begin
  Region.create!({
    region_identifier: 1,
    api_url: 'http://api.pugetsound.onebusaway.org/',
    web_url: 'http://pugetsound.onebusaway.org/',
    name: 'Puget Sound'
  })
rescue
end

begin
  Region.create!({
    region_identifier: 2,
    api_url: 'http://bustime.mta.info/',
    web_url: 'http://bustime.mta.info/',
    name: 'MTA New York'
  })
rescue
end

begin
  Region.create!({
    region_identifier: 3,
    api_url: "http://atlanta.onebusaway.org/api/",
    web_url: "http://atlanta.onebusaway.org/",
    name: "Atlanta"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 4,
    api_url: "http://buseta.wmata.com/onebusaway-api-webapp/",
    web_url: "http://buseta.wmata.com/",
    name: "Washington, D.C."
  })
rescue
end

begin
  Region.create!({
    region_identifier: 5,
    api_url: "http://oba.yrt.ca/",
    web_url: "https://www.yrt.ca/",
    name: "York"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 6,
    api_url: "http://bt.v-a.io/onebusaway/",
    web_url: "http://bt.v-a.io/",
    name: "Bear Transit"
  })
rescue
end

# begin
# Region.create!({
#   region_identifier: 7,
#   api_url: "http://developer.onebusaway.org/mbta-api/",
#   web_url: "TODO",
#   name: "Boston"
# })
# rescue
# end

# begin
# Region.create!({
#   region_identifier: 8,
#   api_url: "http://194.89.230.196:8080/",
#   web_url: "TODO",
#   name: "Lappeenranta"
# })
# rescue
# end

begin
  Region.create!({
    region_identifier: 9,
    api_url: "http://oba.rvtd.org:8080/onebusaway-api-webapp/",
    web_url: "http://www.rvtd.org/",
    name: "Rogue Valley, Oregon"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 10,
    api_url: "http://www.obartd.com/onebusaway-api-webapp/",
    web_url: "http://www.obartd.com/",
    name: "San Joaquin RTD"
  })
rescue
end

begin
  Region.create!({
    region_identifier: 11,
    api_url: "http://realtime.sdmts.com/api/",
    web_url: "http://realtime.sdmts.com",
    name: "San Diego"
  })
rescue
end
