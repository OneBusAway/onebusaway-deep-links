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

  # This task runs every ten minutes, so we set up
  # ten separate jobs to run one minute apart.
  desc 'Enqueues jobs to enqueue alarms.'
  task :queue_alarms => :environment do
    puts "Enqueueing alarms via cron"
    10.times {|i| AlarmQueuerWorker.perform_in(i.minutes, {})}
  end
end