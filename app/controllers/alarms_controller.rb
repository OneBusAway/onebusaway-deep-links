require_dependency 'oba/one_signal'

class AlarmsController < ApplicationController
  before_action :load_region
  skip_before_action :verify_authenticity_token

  def create
    callback_url = notification_callback_region_alarms_url(@region, alarm_id: '#ALARM_ID#')
    response = @region.server.register_alarm(params, callback_url)
    
    puts "Callback URL: #{callback_url}"
    puts "Response: #{response}"
    
    json = begin
      JSON.load(response.body)
    rescue
      nil
    end
    
    render_alarm_creation_error(response) and return if response.code != 200    
    render_alarm_creation_error(response) and return if json.nil?

    alarm_id = json.dig("data", "entry", "alarmId")
    
    render_alarm_creation_error(response) and return if alarm_id.nil?
        
    @alarm = @region.alarms.build({
      alarm_identifier: alarm_id,
      message: "Time to leave for your bus!",
      push_identifier: params[:user_push_id]
    })

    render_alarm_creation_error(response) and return if !@alarm.save

    render json: {url: region_alarm_url(@region, @alarm)}
  end
    
  def destroy
    @alarm = @region.alarms.find_by(secure_token: params[:id])
    @alarm.destroy
    head :ok
  end
  
  def notification_callback
    @alarm = @region.alarms.find_by(alarm_identifier: params[:alarm_id])
    
    puts "Notification callback called for #{@alarm}"
    
    if @alarm.nil?
      head :ok
      return
    end
    
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
