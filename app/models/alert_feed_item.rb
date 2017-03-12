class AlertFeedItem < ApplicationRecord
  belongs_to :alert_feed
  delegate :region, to: :alert_feed

  default_scope { order(published_at: :desc) }
end
