require 'rails_helper'

RSpec.describe AlertFeed, type: :model do
  before :each do
    @region = Region.create!(name:              'My Region',
                             region_identifier: 12345,
                             api_url:           'http://www.example.com',
                             web_url:           'http://www.example.com')

    @feed = AlertFeed.create!(name:         'My Alert Feed',
                              url:          'http://www.example.com',
                              type:         'AlertFeed',
                              region_id:    @region.id,
                              last_fetched: 1.day.ago)
  end

  describe '.fetch' do
    it 'updates the last_fetched attribute' do
      original_last_fetched = @feed.last_fetched
      expect(original_last_fetched).to be < 1.hour.ago

      @feed.fetch
      @feed.reload

      expect(@feed.last_fetched).not_to eql(original_last_fetched)
    end
  end

  describe '.fetch_if_necessary' do
    it 'does not call .fetch if the last_fetched value is > UPDATE_FREQUENCY.seconds.ago' do
      @feed.update_attributes!(last_fetched: Time.now)
      expect(@feed).not_to receive(:fetch)
      @feed.fetch_if_necessary
    end

    it 'calls .fetch if the last_fetched value is nil' do
      @feed.update_attributes!(last_fetched: nil)
      expect(@feed).to receive(:fetch)
      @feed.fetch_if_necessary
    end

    it 'calls .fetch if the last fetched value is < UPDATE_FREQUENCY.seconds.ago' do
      expect(@feed.last_fetched).to be < AlertFeed::UPDATE_FREQUENCY.seconds.ago
      expect(@feed).to receive(:fetch)
      @feed.fetch_if_necessary
    end
  end
end
