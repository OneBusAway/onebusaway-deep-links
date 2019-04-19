class AlarmCheckJob < ApplicationJob
  queue_as :default

  def perform(alarm_id)
    puts "Checking alarm #{alarm_id}."
    checker = AlarmChecker.new(id: alarm_id)
    checker.check_alarm()
  end
end
