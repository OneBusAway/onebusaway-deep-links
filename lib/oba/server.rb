class Server
  attr_accessor :api_base_url
  
  def initialize(api_base_url)
    self.api_base_url = api_base_url
  end
  
  # Alarms
  
  def register_alarm(input_params, callback_url)
    # TODO: validate presence of input
    alarm_time_offset = input_params[:seconds_before]
    stop_id = input_params[:stop_id]
    trip_id = input_params[:trip_id]
    service_date = input_params[:service_date]
    vehicle_id = input_params[:vehicle_id]
    stop_sequence = input_params[:stop_sequence]
    
    url = build_url("register-alarm-for-arrival-and-departure-at-stop", stop_id)
    params = build_params({
      tripId: trip_id,
      serviceDate: service_date,
      vehicleId: vehicle_id,
      stopSequence: stop_sequence,
      alarmTimeOffset: alarm_time_offset,
      url: callback_url
    })
    
    puts " "
    puts "*" * 50
    puts "*" * 50
    
    puts "params: #{params}"
    puts "URL: #{url}"

    puts "*" * 50
    puts "*" * 50
    puts " "

    RestClient.get(url, {params: params})
  end
  
  # Current Time
  
  def current_time
    url = build_url('current-time.json')
    RestClient.get(url, {params: build_params})
  end
  
  private
  
  def build_params(params = {})
    params[:key] = "TEST"
    
    params
  end
  
  def build_url(endpoint, resource = nil)
    parts = [self.api_base_url, "api", "where", endpoint]
    parts << "#{resource}.json" unless resource.nil?
    File.join(*parts)
  end
end