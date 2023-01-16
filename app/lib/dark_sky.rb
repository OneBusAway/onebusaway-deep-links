require 'ostruct'

class DarkSky
  attr_accessor :api_key

  def self.client
    DarkSky.new(Rails.application.credentials.dig(:pirate_weather_api_key))
  end

  def initialize(api_key)
    self.api_key = api_key
  end

  def forecast(region)
    geohash = GeoHash.encode(region.region_center.lat, region.region_center.lon, 4)
    lat,lon = geohash_to_lat_lon(geohash)
    url = build_forecast_url(lat, lon)
    response = RestClient.get(url) rescue nil

    if response&.code == 200
      JSON.parse(response)
    else
      raise "Forecast request was unsuccessful"
    end
  end

  #####################

  private

  DARK_SKY_BASE_URL = 'https://api.pirateweather.net'.freeze

  def geohash_to_lat_lon(geohash)
    GeoHash.decode(geohash).first
  end

  def build_forecast_url(lat, lon)
    "#{DARK_SKY_BASE_URL}/forecast/#{self.api_key}/#{lat},#{lon}?exclude=minutely,daily"
  end
end