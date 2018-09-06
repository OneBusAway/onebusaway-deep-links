module AlertFeedItemsConcerns
  extend ActiveSupport::Concern

  def condition_filters(options = {})
    conditions = {}
    if options[:since].present?
      conditions[:starts_at] = Time.at(options[:since].to_i).to_datetime.utc..Time.now.utc
    end
    conditions
  end
  
  def load_index_data(region, live_data_only = false)
    return [] if region.nil?
    
    opts = condition_filters(params)
    
    if live_data_only
      opts[:test_item] = false
    end

    region.alert_feed_items.includes(:alert_feed).where(opts).limit(20)
  end
end