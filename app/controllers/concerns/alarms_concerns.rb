module AlarmsConcerns
  extend ActiveSupport::Concern

  ###########
  # Creation
  ###########

  def create_alarm_in_region(region)
    alarm = build_alarm_in_region(region)
    render_alarm_creation_error(response, alarm.errors.full_messages) and return unless alarm.save
    render json: {url: region_alarm_url(region, alarm)}
  end

  def render_alarm_creation_error(response, errors = [])
    render json: {error: "Unable to register alarm", messages: errors}, status: response.status
  end

  def build_alarm_in_region(region)
    arrival_departure = region.server.arrival_and_departure(params)

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
      stop_sequence: params[:stop_sequence]
    })
  end
  
  def build_callback_url(region, alarm)
    # TODO: make this less janky :-\
    if Rails.env.production?
      File.join("http://obaco.herokuapp.com", region_alarm_callback_path(region, alarm))
    else
      region_alarm_callback_url(region, alarm)
    end
  end
  
  #############
  # Destruction
  #############
  
  def destroy_alarm_with_token(token, region)
    alarm = region.alarms.find_by(secure_token: token)
    alarm.destroy unless alarm.nil?
    head :ok
  end
  
  ##############
  # Callback
  ##############

  def perform_callback_for_alarm_id(alarm_id, region)
    alarm = region.alarms.find_by(secure_token: alarm_id)

    puts "Notification callback called for #{alarm}"

    head(:ok) and return if alarm.nil?

    client = OneSignal.new(ENV['ONESIGNAL_REST_API_KEY'], ENV['ONESIGNAL_APP_ID'])
    client.send_message(alarm.push_identifier, alarm)

    alarm.destroy

    head :ok
  end
end