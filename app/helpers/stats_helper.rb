module StatsHelper
  def record_pageview(region, page)
    @page_counter = Redis::Counter.new("#{region.region_identifier}:#{page}:#{DateTime.now.strftime("%Y-%m-%d")}")
    @page_counter.increment
    
    @api_counter = Redis::Counter.new("#{region.region_identifier}:api:#{DateTime.now.strftime("%Y-%m-%d")}")
    @api_counter.increment    
  end
end