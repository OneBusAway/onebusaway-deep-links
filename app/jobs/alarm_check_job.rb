class AlarmCheckJob < ApplicationJob
  queue_as :default

  def perform(alarm_id)
    AlarmChecker.check_alarm(alarm_id)
  end
end
