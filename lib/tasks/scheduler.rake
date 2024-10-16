require 'sidekiq'

namespace :obaco do
  desc 'Enqueues jobs to enqueue alarms.'
  task :queue_alarms => :environment do
    puts "Enqueueing alarms via cron"
    alarms = Alarm.all
    puts "Enqueueing #{alarms.count} jobs to inspect alarms."
    alarms.each do |a|
      AlarmCheckJob.perform_later(a.id)
    end
  end
end