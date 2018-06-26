def dark_sky_to_conditions(ds)
  {
    icon: ds['icon'],
    precip_per_hour: ds['precipIntensity'],
    precip_probability: ds['precipProbability'],
    summary: ds['summary'],
    temperature: ds['temperature'],
    temperature_feels_like: ds['apparentTemperature'],
    time: ds['time'],
    wind_speed: ds['windSpeed']    
  }
end

json.latitude(@forecast['latitude'])
json.longitude(@forecast['longitude'])
json.region_identifier(@region.region_identifier)
json.region_name(@region.name)
json.retrieved_at(Time.now)
json.units @forecast['flags']['units']

json.today_summary @forecast['hourly']['summary']
json.current_forecast dark_sky_to_conditions(@forecast['currently'])

json.hourly_forecast @forecast['hourly']['data'].collect {|hour| dark_sky_to_conditions(hour)}
