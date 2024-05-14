class AlarmChecker

  # @param id [Integer] Primary key for an Alarm object.
  # @param server [Server] Optional, used to perform the #arrival_and_departure server call. Pass `nil` here to use the alarm's default server.
  # @param pusher [#send_message] (OneSignal.client) The object that will be used to send the push notification, if required.
  def initialize(id:, server: nil, pusher: OneSignal.client)
    @alarm = Alarm.find(id)
    @server = server
    @pusher = pusher
  end

  # Checks to see if the referenced alarm should be triggered.
  # (i.e. A push notification should be sent.)
  def check_alarm()
    arr_dep = fetch_arr_dep(@alarm)

    if @alarm.seconds_before < arr_dep.seconds_until_departure
      if @debugging
        puts "Alarm #{@alarm.id} is not ready to fire yet. #{arr_dep.seconds_until_departure - @alarm.seconds_before} seconds remain."
      end
      return
    end

    if arr_dep.seconds_until_departure < 0
      @alarm.destroy
      # these should be logged, not treated as exceptions.
      # raise ObaErrors::PastDueAlarmTriggeredError, "An alarm in Region #{@alarm.region_id} was triggered after its due date. seconds_before: #{@alarm.seconds_before}, Late by: #{arr_dep.seconds_until_departure} (+ the seconds_before value.)"
    end

    if @debugging
      puts "Alarm #{@alarm.id} has been triggered. (Seconds Before: #{@alarm.seconds_before} // Time til Departure: #{arr_dep.seconds_until_departure}) Sending a push notification."
    end

    @pusher.send_message(@alarm.push_identifier, @alarm)

    @alarm.destroy
  end

  private

    def server
      @server || @alarm.region.server
    end

    def fetch_arr_dep(alarm)
      arr_dep = server.arrival_and_departure(
        stop_id: alarm.stop_id,
        trip_id: alarm.trip_id,
        service_date: alarm.service_date,
        vehicle_id: alarm.vehicle_id,
        stop_sequence: alarm.stop_sequence
      )

      return arr_dep
    end
end