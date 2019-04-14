
class AlarmChecker

  # Checks to see if the referenced alarm should be triggered. (i.e. A push notification should be sent.)
  #
  # @param id [Integer] Primary key for an Alarm object.
  # @param pusher [#send_message] (OneSignal.client) The object that will be used to send the push notification, if required.
  def self.check_alarm(id:, pusher: OneSignal.client)
    alarm = Alarm.find(id)
    return if alarm.nil?

    arr_dep = fetch_arr_dep(alarm)
    if alarm.seconds_before < arr_dep.seconds_until_departure
      return
    end

    if arr_dep.seconds_until_departure < 0
      alarm.destroy
      raise PastDueAlarmTriggeredError, "An alarm in #{alarm.region_id} was triggered after its due date. seconds_before: #{alarm.seconds_before}, Late by: #{arr_dep.seconds_until_departure} (+ the seconds_before value.)"
    end

    pusher.send_message(alarm.push_identifier, alarm)

    alarm.destroy
  end

  private

    def self.fetch_arr_dep(alarm)
      region = alarm.region
      server = region.server

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