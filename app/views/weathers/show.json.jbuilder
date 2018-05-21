json.latitude(@forecast['latitude'])
json.longitude(@forecast['longitude'])
json.region_identifier(@region.region_identifier)
json.region_name(@region.name)
json.retrieved_at(Time.now)

json.currently(@forecast['currently'])
json.hourly(@forecast['hourly'])
json.alerts(@forecast['alerts'])