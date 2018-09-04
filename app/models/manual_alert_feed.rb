class ManualAlertFeed < AlertFeed
  def fetch
    # no-op
    super
  end
  
  def add_alert_item(title, summary, url)

    # Create the item
    item = self.alert_feed_items.find_or_create_by!(external_id: url) do |item|
      item.title        = title
      item.url          = url
      item.summary      = summary
      item.published_at = DateTime.now
      item.external_id  = url
      item.priority     = AlertFeedItem::HIGH_PRIORITY
    end

    # Poke the record's 'updated at' timestamp
    self.fetch()

    # finally, return the item
    item
  end
end