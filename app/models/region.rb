require_dependency 'oba/server'
require 'ostruct'

# Confusingly, the ids that are passed in to identify
# regions are the id values present in the multiregion
# file: http://regions.onebusaway.org/regions-v3.json
# These values are referred to as `region_identifier`.
#
# The ids that exist locally, in Rails's DB, are
# more or less unused.

class Region < ApplicationRecord
  validates_presence_of :api_url, :web_url, :name, :bounds_list
  validates_numericality_of :region_identifier

  has_many :alarms
  
  def to_param
    "#{self.region_identifier}-#{self.name.parameterize}"
  end
  
  ######
  # Alert Feeds
  ######
  
  has_many :alert_feeds, dependent: :destroy
  has_many :alert_feed_items, through: :alert_feeds

  def manual_feed
    return nil if manual_feed_id.nil?
    
    AlertFeed.find(manual_feed_id)
  end
  
  ######
  # Admins
  ######
  
  has_many :admins, dependent: :destroy
  
  ######
  # Server
  ######

  def server
    @server ||= Server.new(self.api_url)
  end
  
  def agencies
    @agencies ||= server.agencies_with_coverage
  end
  
  ######
  # Geometry
  ######
  
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
  
end
