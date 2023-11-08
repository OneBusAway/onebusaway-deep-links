require 'open-uri'
require 'json'

class Regions
  def self.update_regions
    url = "http://regions.onebusaway.org/regions-v3.json"
    json = JSON.load(open(url).read)
    raise "Unable to load region data" if json['code'] != 200 || json['text'] != 'OK'

    regions = json['data']['list']
    regions.each do |r|
      upsert_region_with_data(r)
    end
  end

  def upsert_region_with_data(data)
    region = Region.find_or_initialize_by(region_identifier: data['id'])
    region.api_url = data['obaBaseUrl']

    # Weirdly, this is not represented in the regions file today.
    region.web_url = "https://#{URI.parse(region.api_url).host}"

    region.bounds_list = data['bounds']

    region.name = data['regionName']
    if !region.save
      puts "Unable to save #{data['regionName']}"
      puts region.errors.full_messages
    end
  end
end