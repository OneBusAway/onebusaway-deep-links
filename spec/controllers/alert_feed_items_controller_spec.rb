require 'rails_helper'

RSpec.describe AlertFeedItemsController, type: :controller do
  
  describe '#items' do
    let(:region) { create_puget_sound_region! }
    before do
      get :items, params: {region_id: region.to_param}
    end
    it 'loads successfully' do
      expect(response.status).to eq(200)
    end
  end
  
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
      before do
        @live_item1 = alert_feed.add_alert_item("live title 1", "live summary 1", "http://example.com/live1", false)
        @live_item2 = alert_feed.add_alert_item("live title 2", "live summary 2", "http://example.com/live2", false)
        
        get :index, params: {region_id: region.region_identifier}
      end

      it 'returns both live items' do
        json = JSON.parse(response.body)
        expect(json.count).to eq(2)
        expect(json.first['id']).to eq(@live_item2.id)
        expect(json.last['id']).to eq(@live_item1.id)
      end
    end
  end
end
