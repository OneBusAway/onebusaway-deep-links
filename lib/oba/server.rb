require 'json'

class Server
  attr_accessor :api_base_url

  def initialize(api_base_url)
    self.api_base_url = api_base_url
  end

  # Arrival and Departure

  def arrival_and_departure(args = {})
    response = RestClient.get(build_arrival_and_departure_url(args))

    json = JSON.parse(response.body)
    arr_dep = ArrivalDeparture.from_json(json['data']['entry'])
    arr_dep.server_response = response

    arr_dep
  end


  def build_arrival_and_departure_url(args)
    params = build_params()
    params[:tripId] = args[:trip_id]
    params[:serviceDate] = args[:service_date]
    params[:vehicleId] = args[:vehicle_id] unless args[:vehicle_id].blank?
    params[:stopSequence] = args[:stop_sequence]

    url = build_url("arrival-and-departure-for-stop", args[:stop_id])
    "#{url}?#{params.to_param}"
  end

  # Alarms

  def register_alarm(input_params, callback_url)
    RestClient.get(build_alarm_url(input_params, callback_url))
  end

  def build_alarm_url(input_params, callback_url)
    params = build_params()
    params[:alarmTimeOffset] = input_params[:seconds_before] unless input_params[:seconds_before].blank?
    params[:url] = callback_url
    params[:tripId] = input_params[:trip_id]
    params[:serviceDate] = input_params[:service_date]
    params[:vehicleId] = input_params[:vehicle_id] unless input_params[:vehicle_id].blank?
    params[:stopSequence] = input_params[:stop_sequence]

    url = build_url("register-alarm-for-arrival-and-departure-at-stop", input_params[:stop_id])
    url_with_params = "#{url}?#{params.to_param}"
    return url_with_params
  end

  # Current Time

  def current_time
    url = build_url('current-time.json')
    RestClient.get(url, {params: build_params})
  end

  private

  def build_params(params = {})
    params[:key] = "org.onebusaway.iphone"
    params[:app_uid] = "C071187D-67E0-458C-A1DA-CADE062AE667"
    params[:app_ver] = "20170105.12"
    params[:version] = "2"

    params
  end

  def build_url(endpoint, resource = nil)
    parts = [self.api_base_url, "api", "where", endpoint]

    unless resource.nil?
      encoded_resource = ERB::Util.url_encode(resource)
      parts << "#{encoded_resource}.json"
    end

    File.join(*parts)
  end
end