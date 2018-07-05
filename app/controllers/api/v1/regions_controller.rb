class Api::V1::RegionsController < Api::V1::ApiController
  skip_before_action :load_region, only: [:index]

  def index
    @regions = Region.all
    respond_to do |format|
      format.json
    end
  end
  
  def vehicles
    @vehicles = Rails.cache.fetch("region:#{@region.region_identifier}:vehicles", expires_in: 30.minutes, race_condition_ttl: 30.seconds) do
      @region.server.all_vehicles_in_region
    end
    render json: @vehicles
  end
end
