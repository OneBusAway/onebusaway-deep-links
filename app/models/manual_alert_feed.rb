class ManualAlertFeed < AlertFeed
  def fetch
    # no-op
    super
  end
    
  def add_alert_item(title, summary, url, test_item = false)
    # Create the item
    item = self.alert_feed_items.find_or_create_by!(external_id: url) do |item|
      item.title        = title
      item.url          = url
      item.summary      = summary
      item.starts_at    = DateTime.now
      item.external_id  = url
      item.severity     = AlertFeedItem::SEVERITY_WARNING
      item.test_item    = test_item
    end

    # Poke the record's 'updated at' timestamp
    self.fetch()

    # finally, return the item
    item
  end
end