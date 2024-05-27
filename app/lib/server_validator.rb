class ServerValidator

  attr_accessor :api_url, :status
  def initialize(server)
    @api_url = server
    @status = []
  end

  def run
    output = fetch("/api/where/current-time.json?key=org.onebusaway.iphone", 'data', 'entry', 'time')
    if output.is_a?(Integer) && output > 0
      @status << 'current-time.json endpoint works'
    else
      @status << 'current-time broken'
      return
    end

    agency_id = fetch("/api/where/agencies-with-coverage.json?key=org.onebusaway.iphone", 'data', 'list', 0, 'agencyId')
    if agency_id.is_a?(String)
      @status << 'agencies-with-coverage.json endpoint works'
    else
      @status << 'agencies-with-coverage broken'
    end

    route_id = fetch("/api/where/routes-for-agency/#{agency_id}.json?key=org.onebusaway.iphone", 'data', 'list', 0, 'id')
    if route_id.is_a?(String)
      @status << 'routes-for-agency endpoint works'
    else
      @status << 'routes-for-agency broken'
      return
    end

    stop_id = fetch("/api/where/stops-for-route/#{route_id}.json?key=org.onebusaway.iphone", 'data', 'entry', 'stopIds', 0)
    if stop_id.is_a?(String)
      @status << 'stops-for-route endpoint works'
    else
      @status << 'stops-for-route broken'
      return
    end

    stop_code = fetch("/api/where/stop/#{stop_id}.json?key=org.onebusaway.iphone", 'data', 'entry', 'code')
    if stop_code.is_a?(String)
      @status << 'stop endpoint works'
    else
      @status << 'stop broken'
      return
    end
  end

  private

  def fetch(endpoint, *args)
    url = File.join(@api_url, endpoint)
    json = URI.open(url).read
    JSON.parse(json).dig(*args)
  end
end