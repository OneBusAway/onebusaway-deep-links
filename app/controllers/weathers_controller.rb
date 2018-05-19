require File.join(Rails.root, 'lib/oba/dark_sky')

class WeathersController < ApplicationController
  before_action :load_region
  
  def show
    geohash = DarkSky.geohash_from(params[:lat], params[:lon], @region)
    
    @forecast = Rails.cache.fetch(DarkSky.cache_key_for_request(@region, geohash), expires_in: 30.minutes, race_condition_ttl: 30.seconds) do
      dark_sky.forecast(geohash)
    end

    respond_to do |format|
      format.json
    end
  end
  
  protected
    
  def geohash_for_request
    lat_lon = lat_lon_from(params, @region)
    GeoHash.encode(lat_lon.lat, lat_lon.lon, 4)
  end
    
  def load_region
    @region = Region.find_by(region_identifier: params[:region_id])
  end
  
  def dark_sky
    @dark_sky ||= DarkSky.client
  end
end
