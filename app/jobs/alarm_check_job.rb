class AlarmCheckJob < ApplicationJob
  queue_as :default

  def perform(alarm_id)
    puts "Checking alarm #{alarm_id}."
    begin
      checker = AlarmChecker.new(id: alarm_id)
      checker.check_alarm()
    rescue ActiveRecord::RecordNotFound
      # Only ignore RecordNotFound errors.
    rescue OBAErrors::EmptyServerResponse
      # ignore this too.
    end
  end
end
