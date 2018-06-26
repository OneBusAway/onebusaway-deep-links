require_dependency 'oba/server'
require 'ostruct'

# Confusingly, the ids that are passed in to identify
# regions are the id values present in the multiregion
# file: http://regions.onebusaway.org/regions-v3.json
# These values are referred to as `region_identifier`.
#
# The ids that exist locally, in Rails's DB, are
# more or less unused.

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

class Region < ApplicationRecord
  validates_presence_of :api_url, :web_url, :name, :bounds_list
  validates_numericality_of :region_identifier

  has_many :alarms
  has_many :alert_feeds
  has_many :alert_feed_items, through: :alert_feeds

  def to_param
    "#{self.region_identifier}-#{self.name.parameterize}"
  end

  def server
    @server ||= Server.new(self.api_url)
  end
  
  def bounding_rect
    @bounding_rect ||= begin
      minX = 360
      minY = 360
      maxX = -360
      maxY = -360
        
      bounds_list.each do |point|
        pt = BoundedPoint.new(point)
        minX = [minX, pt.min_lat].min
        minY = [minY, pt.min_lon].min
        maxX = [maxX, pt.max_lat].max
        maxY = [maxY, pt.max_lon].max
      end
    
      OpenStruct.new(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    end
  end
  
  def region_center
    @region_center ||= begin
      bounds = bounding_rect
      midX = bounds.x + bounds.width / 2.0
      midY = bounds.y + bounds.height / 2.0
    
      OpenStruct.new(lat: midX, lon: midY)
    end
  end
  
  def agencies
    @agencies ||= server.agencies_with_coverage
  end
end
