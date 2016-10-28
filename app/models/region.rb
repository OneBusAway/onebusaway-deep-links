class Region < ApplicationRecord
  validates_presence_of :api_url, :web_url, :name
  validates_numericality_of :region_identifier

  def to_param
    "#{self.region_identifier}-#{self.name.parameterize}"
  end
end
