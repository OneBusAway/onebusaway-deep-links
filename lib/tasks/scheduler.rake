require 'sidekiq'

namespace :obaco do

  desc 'This task is called by the Heroku scheduler add-on'
  task :update_alert_feeds => :environment do
    puts 'Updating alert feeds'
    AlertFeed.find_each do |feed|
      puts "Updating alert feed: \"#{feed.name}\""
      feed.fetch_if_necessary
    end
    puts 'Done updating alert feeds'
  end


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