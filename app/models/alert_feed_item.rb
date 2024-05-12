require_relative '../protobuf/gtfs-realtime.pb.rb'

class AlertFeedItem < ApplicationRecord
  belongs_to :alert_feed
  delegate :region, to: :alert_feed

  default_scope { order(starts_at: :desc) }

  # Severity names and values are from an extension to GTFS-RT.
  SEVERITY_UNKNOWN = 1
  SEVERITY_INFO = 2
  SEVERITY_WARNING = 3
  SEVERITY_SEVERE = 4

  ###########
  # Cause
  ###########

  CAUSES = [
    [:unknown, TransitRealtime::Alert::Cause::UNKNOWN_CAUSE],
    [:other, TransitRealtime::Alert::Cause::OTHER_CAUSE],
    [:technical_problem, TransitRealtime::Alert::Cause::TECHNICAL_PROBLEM],
    [:strike, TransitRealtime::Alert::Cause::STRIKE],
    [:demonstration, TransitRealtime::Alert::Cause::DEMONSTRATION],
    [:accident, TransitRealtime::Alert::Cause::ACCIDENT],
    [:holiday, TransitRealtime::Alert::Cause::HOLIDAY],
    [:weather, TransitRealtime::Alert::Cause::WEATHER],
    [:maintenance, TransitRealtime::Alert::Cause::MAINTENANCE],
    [:construction, TransitRealtime::Alert::Cause::CONSTRUCTION],
    [:police_activity, TransitRealtime::Alert::Cause::POLICE_ACTIVITY],
    [:medical_emergency, TransitRealtime::Alert::Cause::MEDICAL_EMERGENCY]
  ].freeze

  def gtfs_cause
    CAUSES.each do |sym, gtfs_val|
      return gtfs_val if sym == cause
    end

    TransitRealtime::Alert::Cause::UNKNOWN_CAUSE
  end

  enum cause: CAUSES.collect(&:first)

  ###########
  # Effect
  ###########

  EFFECTS = [
    [:no_service, TransitRealtime::Alert::Effect::NO_SERVICE],
    [:reduced_service, TransitRealtime::Alert::Effect::REDUCED_SERVICE],
    [:significant_delays, TransitRealtime::Alert::Effect::SIGNIFICANT_DELAYS],
    [:detour, TransitRealtime::Alert::Effect::DETOUR],
    [:additional_service, TransitRealtime::Alert::Effect::ADDITIONAL_SERVICE],
    [:modified_service, TransitRealtime::Alert::Effect::MODIFIED_SERVICE],
    [:other_effect, TransitRealtime::Alert::Effect::OTHER_EFFECT],
    [:unknown_effect, TransitRealtime::Alert::Effect::UNKNOWN_EFFECT],
    [:stop_moved, TransitRealtime::Alert::Effect::STOP_MOVED]
  ].freeze

  enum effect: EFFECTS.collect(&:first)

  def gtfs_effect
    EFFECTS.each do |sym, gtfs_val|
      return gtfs_val if sym == effect
    end

    TransitRealtime::Alert::Effect::UNKNOWN_EFFECT
  end

  #######

  # [
  #   :no_service,         # 0
  #   :reduced_service,    # 1
  #   :significant_delays, # 2
  #   :detour,             # 3
  #   :additional_service, # 4
  #   :modified_service,   # 5
  #   :other_effect,       # 6
  #   :unknown_effect,     # 7
  #   :stop_moved          # 8
  # ]

  # [
  #     :unknown,            # 0
  #     :other,              # 1
  #     :technical_problem,  # 2
  #     :strike,             # 3
  #     :demonstration,      # 4
  #     :accident,           # 5
  #     :holiday,            # 6
  #     :weather,            # 7
  #     :maintenance,        # 8
  #     :construction,       # 9
  #     :police_activity,    # 10
  #     :medical_emergency   # 11
  #    ]
end
