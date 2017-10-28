desc 'This task is called by the Heroku scheduler add-on'
task :update_alert_feeds => :environment do
  # puts 'Updating alert feeds'
  # AlertFeed.find_each do |feed|
  #   puts "Updating alert feed: \"#{feed.name}\""
  #   feed.fetch_if_necessary
  # end
  # puts 'Done updating alert feeds'
end
