class AlarmBuilder
  attr_accessor :region
  attr_accessor :server

  # param region [Region] The region in which this alarm will be created.
  # param server [Server, nil]
  #   The server object that will be used to fetch arrival/departure information. A default server object
  #   using the specified region will be created if this value is nil.
  def initialize(region:, server: nil)
    self.region = region
    self.server = server || Server.new(region.api_url)
  end

  def build_alarm(params:)
    params = permitted_params(params)
    arrival_departure = self.server.arrival_and_departure(
      stop_id: params[:stop_id],
      service_date: params[:service_date],
      stop_sequence: params[:stop_sequence],
      trip_id: params[:trip_id],
      vehicle_id: params[:vehicle_id]
    )

    seconds = params[:seconds_before].to_i
    seconds = 600 unless seconds > 0

    minutes = (seconds / 60).to_i
    pluralized_minutes = "minute".pluralize(minutes)
    formatted_minutes = "#{minutes} #{pluralized_minutes}"

    region.alarms.build({
      message: "The #{arrival_departure ? arrival_departure.name_with_headsign : 'bus'} leaves in #{formatted_minutes}",
      push_identifier: params[:user_push_id],
      stop_id: params[:stop_id],
      trip_id: params[:trip_id],
      service_date: params[:service_date],
      vehicle_id: params[:vehicle_id],
      stop_sequence: params[:stop_sequence],
      seconds_before: seconds
    })
  end

  private

    def permitted_params(params)
      params.permit(:user_push_id, :stop_id, :trip_id, :service_date, :vehicle_id, :stop_sequence, :seconds_before)
    end
end