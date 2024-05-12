Rails.autoloaders.each do |autoloader|
  autoloader.ignore(Rails.root.join('app/protobuf/gtfs-realtime.pb.rb'))
end