class KingCountyMetroAlertFeed < AlertFeed
  def fetch
    rss = Feedjira::Feed.fetch_and_parse(self.url)
    rss.entries.each do |entry|
      create_feed_item_from_entry(entry)
    end
    super
  end

  def agency_id
    # yes, it's intentionally a string. :-\
    "1"
  end

  private

    def create_feed_item_from_entry(entry)
      summary = parse_summary(entry.summary)
      return if summary.match?(/elevator/i)

      feed_item = self.alert_feed_items.find_or_initialize_by(external_id: entry.entry_id) do |item|
        item.title        = entry.title
        item.url          = entry.url
        item.summary      = parse_summary(entry.summary)
        item.starts_at    = entry.published
        item.external_id  = entry.entry_id
        item.test_item    = false
      end

      feed_item.save!
    end

    def parse_summary(summary)
      doc = Nokogiri::HTML(summary)
      doc.text.gsub(/\n/, ' ').strip
    end
end
