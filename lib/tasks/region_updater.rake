namespace :obaco do
  desc 'Loads the regions-v3 file and then updates or inserts all regions listed in it'
  task :upsert_regions => :environment do
    puts 'Updating regions'
    Regions.new.update_regions
    puts "finished updating regions"
  end
end