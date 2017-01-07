require_dependency 'oba/server'

class Region < ApplicationRecord
  validates_presence_of :api_url, :web_url, :name
  validates_numericality_of :region_identifier
  
  has_many :alarms

  def to_param
    "#{self.region_identifier}-#{self.name.parameterize}"
  end
  
  def server
    @server ||= Server.new(self.api_url)
  end
end
