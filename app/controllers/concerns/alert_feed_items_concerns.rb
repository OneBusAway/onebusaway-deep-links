module AlertFeedItemsConcerns
  extend ActiveSupport::Concern

  def condition_filters(options = {})
    conditions = {}
    if options[:since].present?
      conditions[:starts_at] = Time.at(options[:since].to_i).to_datetime.utc..Time.now.utc
    end
    conditions
  end
  
  def load_index_data(region)
    return [] if region.nil?

    region.alert_feed_items.includes(:alert_feed).where(condition_filters(params)).limit(20)
  end
end