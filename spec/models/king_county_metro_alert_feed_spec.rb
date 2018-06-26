require 'rails_helper'

RSpec.describe KingCountyMetroAlertFeed, type: :model do
  before :each do
    @region = create_region!
    @feed = KingCountyMetroAlertFeed.create!(
      name:         'King County Metro Alert Feed',
      url:          'https://public.govdelivery.com/topics/WAKCDOT_255/feed.rss',
      region_id:    @region.id,
      last_fetched: 1.day.ago
    )
    @mock_response = ['<?xml version="1.0" encoding="UTF-8"?><rss><channel>', '', '</channel></rss>']
  end

  describe '.fetch' do
    it 'sets all available attributes' do
      VCR.use_cassette('king_county_metro_alert_feed') do
        expect(@feed.alert_feed_items.count).to eql(0)

        @feed.fetch
        @feed.reload

        expect(@feed.alert_feed_items.count).to be > 1

        last_feed_item = @feed.alert_feed_items.last
        expect(last_feed_item.created_at).to be > 1.minute.ago
        expect(last_feed_item).to_not be blank?
        expect(last_feed_item.title).to_not be blank?
        expect(last_feed_item.url).to_not be blank?
        expect(last_feed_item.summary).to_not be blank?
        expect(last_feed_item.published_at).to_not be blank?
        expect(last_feed_item.external_id).to_not be blank?
      end
    end

    it 'converts "&amp;" characters in the summary into "&"' do
      @mock_response[1] = <<-XML
        <item>
          <title>Item title</title>
          <link>https://content.govdelivery.com/accounts/WAKING/bulletins/18c9610</link>
          <description>peanut butter &amp; jelly</description>
          <pubDate>Fri, 10 Mar 2017 15:13:14 -0600</pubDate>
        </item>
      XML

      stub_request(:get, @feed.url).to_return(headers: { 'Last-Modified': Time.now.utc.to_s },
                                              body: @mock_response.join)

      @feed.fetch
      @feed.reload

      expect(@feed.alert_feed_items.count).to eql(1)

      last_feed_item = @feed.alert_feed_items.last
      expect(last_feed_item.summary).to eql('peanut butter & jelly')
    end

    it 'trims leading and trailing whitespace in the summary' do
      @mock_response[1] = <<-XML
        <item>
          <title>Item title</title>
          <link>https://content.govdelivery.com/accounts/WAKING/bulletins/18c9610</link>
          <description>     leading and trailing whitespace     </description>
          <pubDate>Fri, 10 Mar 2017 15:13:14 -0600</pubDate>
        </item>
      XML

      stub_request(:get, @feed.url).to_return(headers: { 'Last-Modified': Time.now.utc.to_s },
                                              body:    @mock_response.join)

      @feed.fetch
      @feed.reload

      expect(@feed.alert_feed_items.count).to eql(1)

      last_feed_item = @feed.alert_feed_items.last
      expect(last_feed_item.summary).to eql('leading and trailing whitespace')
    end
  end
end
