class Server
  attr_accessor :api_base_url
  
  def initialize(api_base_url)
    self.api_base_url = api_base_url
  end
  
  # Alarms
  
  def register_alarm(input_params, callback_url)
    params = build_params()
    params[:alarmTimeOffset] = input_params[:seconds_before] unless input_params[:seconds_before].blank?
    params[:url] = callback_url
    params[:tripId] = input_params[:trip_id]
    params[:serviceDate] = input_params[:service_date]
    params[:vehicleId] = input_params[:vehicle_id] unless input_params[:vehicle_id].blank?
    params[:stopSequence] = input_params[:stop_sequence]
    
    url = build_url("register-alarm-for-arrival-and-departure-at-stop", input_params[:stop_id])
    url_with_params = "#{url}?#{params.to_param}"
    response = RestClient.get(url_with_params)
    
    puts " "
    puts "*" * 50
    puts "*" * 50
    
    puts "params: #{params}"
    puts "URL: #{url}"
    puts "URL with Params: #{url_with_params}"
    puts "Response: #{response}"
  
    puts "*" * 50
    puts "*" * 50
    puts " "

    response
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