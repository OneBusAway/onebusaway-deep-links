class AlarmBuilder
  attr_accessor :region
  attr_accessor :server

  # param region [Region] The region in which this alarm will be created.
  # param server [Server] (nil) The server object that will be used to fetch arrival/departure information. A default server object using the specified region will be created if this value is nil.
  def initialize(region:, server: nil)
    self.region = region
    self.server = server || Server.new(region.api_url)
  end


end