class AlertFeedItem < ApplicationRecord
  belongs_to :alert_feed
  delegate :region, to: :alert_feed

  default_scope { order(published_at: :desc) }

  # priority can be NORMAL = 0 or HIGH = 1
  NORMAL_PRIORITY = 0
  HIGH_PRIORITY = 1
end
