class Api::V1::StopsController < Api::V1::ApiController

  def show
    record_pageview(@region, 'stop')
    redirect_to(File.join(@region.web_url, "/where/standard/stop.action?id=#{params[:id]}"), allow_other_host: true)
  end

  def trips
    record_pageview(@region, 'trips')

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
    redirect_to(File.join(@region.web_url, path), allow_other_host: true)
  end
end
