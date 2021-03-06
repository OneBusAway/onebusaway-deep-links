require 'rails_helper'

RSpec.describe PugetSoundManualAlertFeed, type: :model do
  before :each do
    @region = create_region!
    @feed = @region.alert_feeds.create!(
      name: 'Puget Sound Alerts',
      url: nil,
      type: 'PugetSoundManualAlertFeed'
    )
  end

  describe '#add_alert_item' do
    let(:title) { "Manual Alert Item Title" }
    let(:summary) { "Manual Alert Item Title" }
    let(:url) { "http://www.example.com/manual_alert_item" }
    subject { @feed.add_alert_item(title, summary, url) }

    it 'saves the alert item' do
      expect(subject).to_not be_new_record
    end

    it 'sets the title' do
      expect(subject.title).to eq(title)
    end

    it 'sets the summary' do
      expect(subject.summary).to eq(summary)
    end

    it 'sets the URL' do
      expect(subject.url).to eq(url)
    end

    it 'sets the external id to be identical to the url' do
      expect(subject.external_id).to eq(url)
    end

    it 'sets the severity field to be WARNING' do
      expect(subject.severity).to eq(AlertFeedItem::SEVERITY_WARNING)
    end
  end
end
