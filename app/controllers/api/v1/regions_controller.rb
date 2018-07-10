class Api::V1::RegionsController < Api::V1::ApiController
  skip_before_action :load_region, only: [:index]

  def index
    @regions = Region.all
    respond_to do |format|
      format.json
    end
  end
  
  def vehicles
    query = params[:query].try(:downcase).try(:strip)

    if query.nil? || query.length < 3
      render json: []
      return
    end
    
    query_cache_key = "region:#{@region.region_identifier}:agency_vehicles_maps:#{query}"
    
    # Bail early if we already have the data cached.
    if hit = Rails.cache.read(query_cache_key)
      render json: hit
      return
    end

    # Go hit the API for data.
    # [{id: "ID", name: "NAME", vehicles: ["vid1", "vid2", "vid3"]}]
    agency_vehicle_maps = Rails.cache.fetch("region:#{@region.region_identifier}:agency_vehicles_maps", expires_in: 30.minutes, race_condition_ttl: 30.seconds) do
      @region.server.all_vehicles_in_region
    end
  
    # Perform a potentially CPU-expensive filtering operation and cache the results.
    results = Rails.cache.fetch(query_cache_key, expires_in: 5.minutes, race_condition_ttl: 30.seconds) do
      filter_agency_map(agency_vehicle_maps, query)
    end

    render json: results
  end
  
  protected
  
  def filter_agency_map(agency_vehicle_maps, query)
    agency_vehicle_maps.inject([]) do |acc, agency|
      if vehicles = agency[:vehicles]
        filtered = vehicles.select {|v| v.include?(query)}
        if filtered.count > 0
          acc << { id: agency[:id], name: agency[:name], vehicles: filtered }
        end
      end
      acc
    end
  end
end
