require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job, time|
    puts "Running #{job}, at #{time}"
    "#{job}".constantize.perform_later
  end

  puts "Starting AlarmQueuerJob at 1 minute intervals."
  every(1.minute, 'AlarmQueuerJob')
end