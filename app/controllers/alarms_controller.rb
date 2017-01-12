require_dependency 'oba/one_signal'

class AlarmsController < ApplicationController
  before_action :load_region
  skip_before_action :verify_authenticity_token

  def create
    arrival_departure = @region.server.arrival_and_departure(params)
        
    @alarm = @region.alarms.build({
      message: "Time to leave for the #{arrival_departure ? arrival_departure.name_with_headsign : 'bus'}",
      push_identifier: params[:user_push_id]
    })

    render_alarm_creation_error(response) and return if !@alarm.save
        
    # TODO: make this less janky :-\
    callback_url = if Rails.env.production?
      File.join("http://obaco.herokuapp.com", region_alarm_callback_path(@region, @alarm))
    else
      region_alarm_callback_url(@region, @alarm)
    end
    
    puts "*" * 50
    puts "*" * 50

    puts "Response: #{response}"
    puts "Specified Callback URL: #{callback_url}"

    puts "*" * 50
    puts "*" * 50

    response = @region.server.register_alarm(params, callback_url)

    render json: {url: region_alarm_url(@region, @alarm)}
  end
    
  def destroy
    @alarm = @region.alarms.find_by(secure_token: params[:id])
    @alarm.destroy
    head :ok
  end
  
  def callback
    @alarm = @region.alarms.find_by(secure_token: params[:alarm_id])
    
    puts "Notification callback called for #{@alarm}"
    
    head(:ok) and return if @alarm.nil?
    
    client = OneSignal.new(ENV['ONESIGNAL_REST_API_KEY'], ENV['ONESIGNAL_APP_ID'])
    client.send_message(@alarm.push_identifier, @alarm.message)
    
    @alarm.destroy
    
    head :ok
  end
  
  protected

  def render_alarm_creation_error(response)
    render json: {error: "Unable to register alarm"}, status: response.status
  end
  
  def load_region
    @region = Region.find_by(region_identifier: params[:region_id])
  end
end
