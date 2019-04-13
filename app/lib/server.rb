require 'json'

class Server
  attr_accessor :api_base_url

  def initialize(api_base_url)
    self.api_base_url = api_base_url
  end

  ########################
  # Arrival and Departure
  ########################

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

  ########################
  # Current Time
  ########################

  def current_time
    url = build_url('current-time.json')
    RestClient.get(url, {params: build_params})
  end

  ########################
  # Agencies
  ########################

  def agencies_with_coverage
    url = build_url('agencies-with-coverage.json')
    begin
      response = RestClient.get(url, {params: build_params})
    rescue
      puts "Failed to load data from #{url}"
      puts $!
      return []
    end

    json = JSON.parse(response.body)
    agencies = json['data']['references']['agencies']
    service_rects = json['data']['list']

    agency_map = agencies.inject({}) do |acc, a|
      acc[a['id']] = Agency.from_json(a)
      acc
    end

    service_rects.each do |sr|
      agency = agency_map[sr['agencyId']]
      agency.read_bounding_rect_from_json(sr) unless agency.nil?
    end

    agency_map.values
  end

  def vehicle_ids_for_agency(agency_id)
    encoded_id = URI.escape(agency_id)
    url = build_url("vehicles-for-agency/#{encoded_id}.json")
    response = RestClient.get(url, {params: build_params})
    json = JSON.parse(response.body)
    list = json['data']['list']
    list.collect {|v| v['vehicleId'] }
  end

  def all_vehicles_in_region
    agencies_with_coverage.collect do |agency|
      {id: agency.id, name: agency.name, vehicles: vehicle_ids_for_agency(agency.id)}
    end
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