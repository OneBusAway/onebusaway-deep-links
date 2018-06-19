module ModelsHelper
  def create_puget_sound_region!
    Region.create!({
      region_identifier: 1, api_url: 'http://api.pugetsound.onebusaway.org/', web_url: 'http://pugetsound.onebusaway.org/', name: 'Puget Sound',
      bounds_list: [{"lat"=>47.221315, "lon"=>-122.4051325, "latSpan"=>0.33704, "lonSpan"=>0.440483}, {"lat"=>47.5607395, "lon"=>-122.1462785, "latSpan"=>0.743251, "lonSpan"=>0.720901}, {"lat"=>47.556288, "lon"=>-122.4013255, "latSpan"=>0.090694, "lonSpan"=>0.126793}, {"lat"=>47.093563, "lon"=>-122.701637, "latSpan"=>0.320892, "lonSpan"=>0.55098}, {"lat"=>47.5346090123, "lon"=>-122.3294835, "latSpan"=>0.889378024643, "lonSpan"=>0.621109}, {"lat"=>47.9747595, "lon"=>-122.8512, "latSpan"=>1.336481, "lonSpan"=>1.0904}, {"lat"=>47.6204755, "lon"=>-122.335392, "latSpan"=>0.014397, "lonSpan"=>0.00635600000001}, {"lat"=>47.64585, "lon"=>-122.2963, "latSpan"=>0.0669, "lonSpan"=>0.0802}, {"lat"=>47.9347358907, "lon"=>-121.993246104, "latSpan"=>0.68796117128, "lonSpan"=>0.784555996061}]
    })
  end
  
  def create_region!
    Region.create!(
          name:              'My Region',
          region_identifier: 12345,
          api_url:           'http://www.example.com',
          web_url:           'http://www.example.com'
        )
  end
end

