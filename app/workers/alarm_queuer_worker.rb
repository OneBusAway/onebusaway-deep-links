class AlarmQueuerWorker
  include Sidekiq::Worker

  def perform(*args)
    alarms = Alarm.all
    puts "Enqueueing #{alarms.count} jobs to inspect alarms."
    alarms.each do |a|
      AlarmCheckJob.perform_later(a.id)
    end
  end
end