class StopsController < ApplicationController

  def show
    @region = Region.find_by(region_identifier: params[:region_id])

    # TODO: needs special handling
    # Washington DC - Region API ID: 4
    # York - Region API ID: 5
    # Bear Transit - Region API ID: 6

    # Not handled currently:
    # MTA New York - Region API ID 2

    redirect_to File.join(@region.web_url, "/where/standard/stop.action?id=#{params[:id]}")
  end

  def arrivals
    @region = Region.find_by(region_identifier: params[:region_id])
    @stop_id = params[:stop_id]
    @trip_id = params[:trip_id]
    @service_date = params[:service_date]

    web_params = {
      id: @trip_id,
      serviceDate: @service_date,
      showVehicleId: "true",
      stopID: @stop_id
    }

    path = "/where/standard/trip.action?#{web_params.to_param}"
    redirect_to File.join(@region.web_url, path)
  end
end
