require 'json'

class Server
  attr_accessor :api_base_url

  def initialize(api_url)
    self.api_base_url = api_url
  end

  ########################
  # Arrivals and Departures
  ########################

  # Requests data from the `arrivals-and-departures-for-stop/{stop_id}.json` endpoint.
  #
  # @param stop_id [String]
  # @param minutes_before [Integer] Default 5
  # @param minutes_after [Integer] Default 35
  def arrivals_and_departures(stop_id:, minutes_before: 5, minutes_after: 35)
    params = build_params()
    params[:minutesBefore] = minutes_before
    params[:minutesAfter] = minutes_after

    url = build_url("arrivals-and-departures-for-stop", stop_id)
    url = "#{url}?#{params.to_param}"
    response = RestClient.get(url)

    raise ObaErrors::EmptyServerResponse if response.body.blank?

    JSON.parse(response.body)
  end

  ########################
  # Arrival and Departure
  ########################

  # Requests data from the `arrival-and-departure-for-stop/{stop_id}.json` endpoint.
  #
  # @param service_date [Integer]
  # @param stop_id [String]
  # @param stop_sequence [Integer]
  # @param trip_id [String]
  # @param vehicle_id [String] (`nil`)
  def arrival_and_departure(stop_id:, service_date:, stop_sequence:, trip_id:, vehicle_id:)
    url = build_arrival_and_departure_url(stop_id: stop_id, service_date: service_date, stop_sequence: stop_sequence,
                                          trip_id: trip_id, vehicle_id: vehicle_id)
    response = RestClient.get(url)

    raise ObaErrors::EmptyServerResponse, "response.body is blank" if response.body.blank?

    json = JSON.parse(response.body)

    raise ObaErrors::EmptyServerResponse, "json is blank" if json.blank?

    entry = json.dig('data', 'entry')

    raise ObaErrors::EmptyServerResponse, "entry is blank" if entry.blank?

    arr_dep = ArrivalDeparture.from_json(entry)
    arr_dep.current_server_time = json["currentTime"]
    arr_dep
  end

  # @param service_date [Integer]
  # @param stop_id [String]
  # @param stop_sequence [Integer]
  # @param trip_id [String]
  # @param vehicle_id [String] (`nil`)
  def build_arrival_and_departure_url(stop_id:, stop_sequence:, service_date:, trip_id:, vehicle_id: nil)
    params = build_params()
    params[:tripId] = trip_id
    params[:serviceDate] = service_date
    params[:vehicleId] = vehicle_id unless vehicle_id.blank?
    params[:stopSequence] = stop_sequence

    url = build_url("arrival-and-departure-for-stop", stop_id)
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
    encoded_id = uri_parser.escape(agency_id)
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

    def uri_parser
      @uri_parser ||= URI::Parser.new
    end

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