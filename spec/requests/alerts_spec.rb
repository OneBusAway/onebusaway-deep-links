require 'rails_helper'

describe Api::V1::AlertsController, type: :request do
  describe 'index' do
    let(:region) { create_puget_sound_region! }
    let(:alert_feed) { create_puget_sound_manual_alert_feed(region) }

    context 'when test mode items exist' do
      before do
        test_item = alert_feed.add_alert_item("test title", "test summary", "http://example.com/test", true)
        @live_item = alert_feed.add_alert_item("live title", "live summary", "http://example.com/live", false)
        
        get("/api/v1/regions/#{region.to_param}/alerts.pb", params: {})
        
        msg = TransitRealtime::FeedMessage.parse(response.body)
        @entities = msg.entity
        @pb_alert = @entities.first.alert
      end
      
      it "returns a 200 status code" do
        expect(response.status).to eq(200)
      end
      
      it 'only returns live items' do
        expect(@entities.count).to eq(1)
      end
      
      it "has the correct url" do
        expect(@pb_alert.url.translation.first.text).to_not be_nil
        expect(@pb_alert.url.translation.first.text).to eq(@live_item.url)
      end
      
      it "has the correct title" do
        expect(@pb_alert.header_text.translation.first.text).to_not be_nil
        expect(@pb_alert.header_text.translation.first.text).to eq(@live_item.title)
      end
      
      it "has the correct summary" do
        expect(@pb_alert.description_text.translation.first.text).to_not be_nil
        expect(@pb_alert.description_text.translation.first.text).to eq(@live_item.summary)
      end
      
      it "has the correct period" do
        period = @pb_alert.active_period.first
        start = Time.at(period.start).to_datetime
        ending = Time.at(period.end).to_datetime
        
        expect(start).to_not be_nil
        expect(start.utc).to be_within(1.second).of @live_item.starts_at.utc
        
        expect(ending).to_not be_nil
        expect(ending.utc).to be_within(1.second).of (@live_item.starts_at + 8.hours).utc
      end
      
      it "has the correct cause" do
        expect(@pb_alert.cause).to eq(1) # unknown
      end
      
      it "has the correct effect" do
        expect(@pb_alert.effect).to eq(8) # unknown
      end
    end

    context 'with test flag passed in' do
      before do
        @test_item = alert_feed.add_alert_item("test title", "test summary", "http://example.com/test", true)
        @live_item = alert_feed.add_alert_item("live title", "live summary", "http://example.com/live", false)
        
        get("/api/v1/regions/#{region.to_param}/alerts.pb", params: {test: '1'})
        
        msg = TransitRealtime::FeedMessage.parse(response.body)
        @entities = msg.entity
      end
      
      it "returns two entities" do
        expect(@entities.count).to eq(2)
      end
    end
  end
end