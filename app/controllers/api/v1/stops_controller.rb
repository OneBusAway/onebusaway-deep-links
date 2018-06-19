class Api::V1::StopsController < Api::V1::ApiController
  def show
    @region = Region.find_by!(region_identifier: params[:region_id])
    redirect_to File.join(@region.web_url, "/where/standard/stop.action?id=#{params[:id]}")
  end
  
  def trips
    @region = Region.find_by!(region_identifier: params[:region_id])
    @stop_id = params[:stop_id]
    @trip_id = params[:trip_id]
    @service_date = params[:service_date]
    @stop_sequence = params[:stop_sequence]

    web_params = {
      id: @trip_id,
      serviceDate: @service_date,
      showVehicleId: "true",
      stopID: @stop_id,
      stopSequence: @stop_sequence
    }

    path = "/where/standard/trip.action?#{web_params.to_param}"
    redirect_to File.join(@region.web_url, path)
  end
end
