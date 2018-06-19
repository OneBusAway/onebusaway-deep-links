json.array! @regions do |region|
  json.id region.region_identifier
  json.name region.name

  json.oba_api_url region.api_url
  json.web_url region.web_url
  json.weather_url api_v1_region_weather_url(region)
  
  json.path_templates do
    json.stop_path Zooplankton.path_template_for(:api_v1_region_stop, region_id: region.region_identifier)
    json.trip_status_path Zooplankton.path_template_for(:api_v1_region_stop_trips, %i(trip_id service_date stop_sequence), region_id: region.region_identifier)    

    # weather
    # create alarm
    # destroy alarm
  end
end
