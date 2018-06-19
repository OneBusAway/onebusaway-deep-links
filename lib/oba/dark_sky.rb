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
    response = RestClient.get(url)

    if !Rails.env.test?
      puts "*** DarkSky Status ***"
      puts "Forecast API Calls: #{response.headers[:x_forecast_api_calls]}"
      puts "Response Time: #{response.headers[:x_response_time]}"
    end

    if response.code == 200
      JSON.parse(response)
    else
      puts "Forecast request was unsuccessful: #{response.code} (#{response.body})"
      raise "Forecast request was unsuccessful"
    end
  end
  
  ###### Public Helpers
  
  def self.lat_lon_from(lat_param, lon_param, region)
    @lat_lon_for_request ||= begin
      if lat_param.nil? || lon_param.nil?
        lat = region.region_center.lat
        lon = region.region_center.lon
      else
        lat = lat_param.to_f
        lon = lon_param.to_f
      end
      OpenStruct.new(lat: lat, lon: lon)
    end
  end
  
  def self.geohash_from(params_lat, params_lon, region)
    lat_lon = lat_lon_from(params_lat, params_lon, region)
    GeoHash.encode(lat_lon.lat, lat_lon.lon, 4)
  end
  
  def self.cache_key_for_request(region, geohash)
    "regions/#{region.id}/weather/#{geohash}"
  end
    
  #####################
  
  private
  
  DARK_SKY_BASE_URL = 'https://api.darksky.net/forecast'.freeze
  
  def geohash_to_lat_lon(geohash)
    GeoHash.decode(geohash).first
  end
  
  def build_forecast_url(lat, lon) #d696019373dc132e9a0c419f4b131bcd
    "#{DARK_SKY_BASE_URL}/#{self.api_key}/#{lat},#{lon}?exclude=minutely,daily"
  end
end