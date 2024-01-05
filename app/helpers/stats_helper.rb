module StatsHelper
  def record_pageview(region, page)
    # disabling this feature for now. I have never looked at it and it's blowing up our Redis usage.

    # @page_counter = Redis::Counter.new("#{region.region_identifier}:#{page}:#{DateTime.now.strftime("%Y-%m-%d")}")
    # @page_counter.increment
    #
    # @api_counter = Redis::Counter.new("#{region.region_identifier}:api:#{DateTime.now.strftime("%Y-%m-%d")}")
    # @api_counter.increment
  end
end