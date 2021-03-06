require 'ostruct'

class DarkSky
  attr_accessor :api_key

  def self.client
    DarkSky.new(ENV['DARKSKY_API_KEY'])
  end

  def initialize(api_key)
    self.api_key = api_key
  end

  def forecast(geohash)
    lat,lon = geohash_to_lat_lon(geohash)
    url = build_forecast_url(lat, lon)
    response = RestClient.get(url) rescue nil

    if response&.code == 200
      JSON.parse(response)
    else
      raise "Forecast request was unsuccessful"
    end
  end

  ###### Public Helpers

  def self.geohash_from(region)
    GeoHash.encode(region.region_center.lat, region.region_center.lon, 4)
  end

  #####################

  private

  DARK_SKY_BASE_URL = 'https://api.darksky.net/forecast'.freeze

  def geohash_to_lat_lon(geohash)
    GeoHash.decode(geohash).first
  end

  def build_forecast_url(lat, lon)
    "#{DARK_SKY_BASE_URL}/#{self.api_key}/#{lat},#{lon}?exclude=minutely,daily"
  end
end