require 'rails_helper'

describe "Api::V1::StopsController", type: :request do
  let(:puget_sound) { create_puget_sound_region! }
  let(:stop_id) { '12345' }

  describe "GET /api/v1/regions/{region_id}/stops/{id}" do
    before do
      get_json("/api/v1/regions/#{puget_sound.region_identifier}/stops/#{stop_id}")
    end

    it { has_status_code(302) }

    it 'redirects the user to the regional OBA server web interface' do
      expect(response).to redirect_to("http://pugetsound.onebusaway.org/where/standard/stop.action?id=12345")
    end
  end

  describe "GET /api/v1/regions/{region_id}/stops/{id}/trips" do
    let(:trip_id) { 'tripid_1' }
    let(:service_date) { '1234567890' }
    let(:stop_sequence) { '1' }

    before do
      path = "/api/v1/regions/#{puget_sound.region_identifier}/stops/#{stop_id}/trips"
      params = { trip_id:, service_date:, stop_sequence: }
      get_json("#{path}?#{params.to_query}")
    end

    it { has_status_code(302) }

    it 'redirects the user to the regional OBA server web interface' do
      expect(response).to redirect_to("http://pugetsound.onebusaway.org/where/standard/trip.action?id=#{trip_id}&serviceDate=#{service_date}&showVehicleId=true&stopID=#{stop_id}&stopSequence=#{stop_sequence}")
    end
  end
end