class AlarmQueuerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Alarm.all.each do |a|
      AlarmCheckJob.perform_later(a.id)
    end
  end
end
