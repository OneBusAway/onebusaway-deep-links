class ArrivalDeparture

  attr_accessor :route_short_name
  attr_accessor :trip_headsign
  attr_accessor :predicted_departure_time
  attr_accessor :scheduled_departure_time
  attr_accessor :current_server_time

  def self.from_json(hash)
    ad = ArrivalDeparture.new

    hash.each do |key, value|
      method_name = "#{key.underscore}="
      if ad.respond_to?(method_name)
        ad.send(method_name, value)
      end
    end

    ad
  end

  def name_with_headsign
    if trip_headsign.blank?
      route_short_name
    else
      "#{route_short_name} to #{trip_headsign}"
    end
  end

  def best_departure_time
    if self.predicted_departure_time != 0
      self.predicted_departure_time
    else
      self.scheduled_departure_time
    end
  end

  # Returns the number of seconds until the departure occurs.
  # Positive numbers indicate that the departure occurs in the future.
  # Negative numbers indicate that the departure occurred in the past.
  #
  # @Return [Integer] The number of seconds until departure.
  def seconds_until_departure
    (best_departure_time - current_server_time) / 1000
  end

  # arrivalEnabled
  # blockTripSequence
  # departureEnabled
  # distanceFromStop
  # frequency
  # lastUpdateTime
  # numberOfStopsAway
  # predicted
  # predictedArrivalInterval
  # predictedArrivalTime
  # predictedDepartureInterval
  # predictedDepartureTime
  # routeId
  # routeLongName
  # routeShortName
  # scheduledArrivalInterval
  # scheduledArrivalTime
  # scheduledDepartureInterval
  # serviceDate
  # situationIds
  # status
  # stopId
  # stopSequence
  # totalStopsInTrip
  # tripHeadsign
  # tripId
  # tripStatus
  # vehicleId
end