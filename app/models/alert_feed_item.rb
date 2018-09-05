class AlertFeedItem < ApplicationRecord
  belongs_to :alert_feed
  delegate :region, to: :alert_feed

  default_scope { order(starts_at: :desc) }

  # priority can be NORMAL = 0 or HIGH = 1
  NORMAL_PRIORITY = 0
  HIGH_PRIORITY = 1
  
  enum cause: [ :unknown, :other, :technical_problem, :strike, :demonstration, :accident, :holiday, :weather, :maintenance, :construction, :police_activity, :medical_emergency ]
  
  enum effect: [ :no_service, :reduced_service, :significant_delays, :detour, :additional_service, :modified_service, :other_effect, :unknown_effect, :stop_moved ]
end
