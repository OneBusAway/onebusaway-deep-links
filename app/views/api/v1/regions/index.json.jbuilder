json.array! @regions do |region|
  json.id region.region_identifier
  json.name region.name

  json.oba_api_url region.api_url
  json.web_url region.web_url
  
  json.path_templates do
    json.create_alarm_path Zooplankton.path_template_for(:api_v1_region_alarms, region_id: region.to_param)    
    json.alerts_path Zooplankton.path_template_for(:api_v1_region_alerts, region_id: region.to_param)
    json.stop_path Zooplankton.path_template_for(:api_v1_region_stop, region_id: region.to_param)
    json.trip_status_path Zooplankton.path_template_for(:api_v1_region_stop_trips, %i(trip_id service_date stop_sequence), region_id: region.to_param)
    json.weather_path Zooplankton.path_template_for(:api_v1_region_weather, %i(lat lon), region_id: region.to_param)
  end
end
