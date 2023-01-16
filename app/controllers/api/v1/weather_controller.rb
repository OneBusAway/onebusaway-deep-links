class Api::V1::WeatherController < Api::V1::ApiController
  def show
    record_pageview(@region, 'weather')

    begin
      @forecast = Rails.cache.fetch("regions/#{@region.to_param}/weather", expires_in: 30.minutes, race_condition_ttl: 30.seconds) do
        dark_sky.forecast(@region)
      end
      respond_to do |format|
        format.json
      end
    rescue
      render nothing: true, status: :forbidden
    end
  end

  protected

  def geohash_for_request
    GeoHash.encode(@region.region_center.lat, @region.region_center.lon, 4)
  end

  def dark_sky
    @dark_sky ||= DarkSky.client
  end
end
