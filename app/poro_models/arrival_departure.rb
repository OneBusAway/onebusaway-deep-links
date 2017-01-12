class ArrivalDeparture
  
  attr_accessor :route_short_name
  attr_accessor :trip_headsign
  attr_accessor :server_response

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
  # scheduledDepartureTime
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