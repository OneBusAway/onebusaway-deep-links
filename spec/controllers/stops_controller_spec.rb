require 'rails_helper'

RSpec.describe StopsController, type: :controller do
  context 'given a region that exists' do
    let(:region_identifier) { "808" }
    let(:region) { double("region", region_identifier: region_identifier, web_url: 'http://example.com/region_test_url/') }
    before(:each) do
      expect(Region).to receive(:find_by!).with(region_identifier: region_identifier).and_return(region)
    end

    describe 'GET trips' do
      subject do
        get(:trips, 
            params: {region_id: region_identifier, stop_id: '123', trip_id: '456', service_date: '1234567890', 
                     stop_sequence: 3})
      end
      it "redirects the caller to the trips web url for the specified region" do
        expect(subject).to redirect_to("http://example.com/region_test_url/where/standard/trip.action?id=456&serviceDate=1234567890&showVehicleId=true&stopID=123&stopSequence=3")
      end
    end
  end

  context "given a region that does not exist" do
    let(:nonexistent) { "999" }
    describe 'GET trips' do
      subject do
        get(:trips, 
            params: {region_id: nonexistent, stop_id: '123', trip_id: '456', service_date: '1234567890', 
                     stop_sequence: 3})
      end
      it "redirects the caller to the trips web url for the specified region" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
