require 'rails_helper'

RSpec.describe AlertFeedItemsController, type: :controller do
  describe '#index' do
    let(:region) { create_puget_sound_region! }
    let(:alert_feed) { create_puget_sound_manual_alert_feed(region) }

    context 'when test mode items exist' do
      before do
        test_item = alert_feed.add_alert_item("test title", "test summary", "http://example.com/test", true)
        @live_item = alert_feed.add_alert_item("live title", "live summary", "http://example.com/live", false)
        
        get :index, params: {region_id: region.region_identifier}
      end
      
      it 'only returns live items' do
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first['id']).to eq(@live_item.id)
      end
    end
    
    context 'when only live items exist' do
      it 'fails' do
        expect(0).to eq(1)
      end
    end
  end
end
