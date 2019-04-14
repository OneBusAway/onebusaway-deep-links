module AlarmsConcerns
  extend ActiveSupport::Concern

  ###########
  # Creation
  ###########

  def permitted_params(params)
    params.permit(:user_push_id, :stop_id, :trip_id, :service_date, :vehicle_id, :stop_sequence, :seconds_before)
  end

  def create_alarm_in_region(region:, params:)
    alarm = build_alarm(region: region, params: permitted_params(params))
    render_alarm_creation_error(response, alarm.errors.full_messages) and return unless alarm.save
    render json: {url: region_alarm_url(region, alarm)}
  end

  def render_alarm_creation_error(response, errors = [])
    render json: {error: "Unable to register alarm", messages: errors}, status: response.status
  end

  def build_alarm(region:, params:)
    arrival_departure = region.server.arrival_and_departure(
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

  #############
  # Destruction
  #############

  def destroy_alarm_with_token(token, region)
    alarm = region.alarms.find_by(secure_token: token)
    alarm.destroy unless alarm.nil?
    head :ok
  end
end