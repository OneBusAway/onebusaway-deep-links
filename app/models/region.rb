class Region < ApplicationRecord
  validates_presence_of :api_url, :web_url, :name
  validates_numericality_of :region_identifier
end
