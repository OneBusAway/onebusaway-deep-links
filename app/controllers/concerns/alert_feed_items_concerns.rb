module AlertFeedItemsConcerns
  extend ActiveSupport::Concern

  def condition_filters(options = {})
    conditions = {}
    if options[:since].present?
      conditions[:published_at] = Time.at(options[:since].to_i).to_datetime.utc..Time.now.utc
    end
    conditions
  end
end