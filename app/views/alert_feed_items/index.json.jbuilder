json.array!(@items) do |item|
  json.id(item.id)
  json.alert_feed_name(item.alert_feed.name)
  json.alert_feed_id(item.alert_feed_id)
  json.title(item.title)
  json.url(item.url)
  json.summary(item.summary)
  json.published_at(item.published_at)
  json.external_id(item.external_id)
  json.priority(item.priority)
end