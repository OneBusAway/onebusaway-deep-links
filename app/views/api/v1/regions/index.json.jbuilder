json.array! @regions do |region|
  json.id region.region_identifier
  json.name region.name

  json.oba_api_url region.api_url
  json.web_url region.web_url

  json.path_templates do
    json.create_alarm_path api_v1_region_alarms_path(region_id: region.to_param)
    json.alerts_path api_v1_region_alerts_path(region_id: region.to_param)
    json.stop_path api_v1_region_stop_path(region_id: region.to_param, id: "TKREPLACEME").gsub("TKREPLACEME", "{id}")
    json.trip_status_path api_v1_region_stop_trips_path(region_id: region.to_param, stop_id: "TKREPLACEME").gsub(
      "TKREPLACEME", "{stop_id}"
    ) + "{?trip_id,service_date,stop_sequence}"
    json.weather_path api_v1_region_weather_path(region_id: region.to_param) + "{?lat,lon}"
  end
end
