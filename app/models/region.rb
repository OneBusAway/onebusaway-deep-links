require_dependency 'oba/server'

# Confusingly, the ids that are passed in to identify
# regions are the id values present in the multiregion
# file: http://regions.onebusaway.org/regions-v3.json
# These values are referred to as `region_identifier`.
#
# The ids that exist locally, in Rails's DB, are
# more or less unused.
class Region < ApplicationRecord
  validates_presence_of :api_url, :web_url, :name
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
end
