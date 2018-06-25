class SoundTransitAlertFeed < AlertFeed
  def fetch
    rss = Feedjira::Feed.fetch_and_parse(self.url)
    rss.entries.each do |entry|
      match = /^.*\/node\/(\d+)$/.match(entry.url)
      next unless match.present?
      entry_id = match[1]

      self.alert_feed_items.find_or_create_by!(external_id: entry_id) do |item|
        item.title        = entry.title
        item.url          = entry.url
        item.summary      = parse_summary(entry.summary)
        item.published_at = entry.published
        item.external_id  = entry_id
      end
    end
    super
  end
  
  def agency_id
    # yes, it's intentionally a string. :-\
    "40"
  end

  private

  def parse_summary(summary)
    doc  = Nokogiri::HTML.parse(summary)
    text = doc.text.strip
    text.gsub!('&amp;', '&')
    text
  end
end
