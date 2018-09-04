class BoundedPoint
  attr_accessor :lat, :lon, :lat_span, :lon_span

  def initialize(dict)
    self.lat = dict['lat']
    self.lon = dict['lon']
    self.lat_span = dict['latSpan']
    self.lon_span = dict['lonSpan']
  end
  
  def lat_radius
    lat_span / 2.0
  end
  
  def lon_radius
    lon_span / 2.0
  end
  
  def top_left_point
    OpenStruct.new(lat: lat - lat_radius, lon: lon + lon_radius)
  end
  
  def bottom_right_point
    OpenStruct.new(lat: lat + lat_radius, lon: lon - lon_radius)
  end
  
  def min_lat
    [top_left_point.lat, bottom_right_point.lat].min
  end
  
  def max_lat
    [top_left_point.lat, bottom_right_point.lat].max
  end
  
  def min_lon
    [top_left_point.lon, bottom_right_point.lon].min
  end
  
  def max_lon
    [top_left_point.lon, bottom_right_point.lon].max
  end
end