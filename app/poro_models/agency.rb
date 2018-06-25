class Agency
  
  attr_accessor :disclaimer
  attr_accessor :email
  attr_accessor :fare_url
  attr_accessor :id
  attr_accessor :lang
  attr_accessor :name
  attr_accessor :phone
  attr_accessor :private_service
  attr_accessor :timezone
  attr_accessor :url
  
  # location stuff - imported via #read_bounding_rect_from_json
  attr_accessor :lat
  attr_accessor :lat_span
  attr_accessor :lon
  attr_accessor :lon_span

  def self.from_json(hash)
    obj = Agency.new

    hash.each do |key, value|
      method_name = "#{key.underscore}="
      obj.send(method_name, value) if obj.respond_to?(method_name)
    end

    obj
  end

  def read_bounding_rect_from_json(hash)
    self.lat = hash['lat']
    self.lat_span = hash['latSpan']

    self.lon = hash['lon']
    self.lon_span = hash['lonSpan']
  end
end