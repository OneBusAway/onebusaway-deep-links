require 'rails_helper'

describe "Api::V1::AlarmsController", type: :request do
  describe "POST /api/v1/regions/:id/alarms" do
    context 'with a bad region ID' do
      before do
        post("/api/v1/regions/BAD_ID/alarms", params: {})
      end

      it 'returns status 404' do
        expect(response.status).to eq(404)
      end

      it 'has a json body with an error message' do
        expect(json).to eq({ "error" => "Couldn't find Region" })
      end
    end

    context 'with a well formed request' do
      let(:region) { create_puget_sound_region! }
      let(:alarm) { Alarm.new(region: region, push_identifier: "12345", message: "Lorem ipsum 123") }
      subject {
        post(api_v1_region_alarms_path(region), params: {
          user_push_id: "12345",
          stop_id: "stop_abc123",
          trip_id: "trip_123",
          service_date: 1234567890,
          vehicle_id: "1_1234",
          stop_sequence: 11,
          seconds_before: 600,
        })
      }

      before do
        @copy = double('alarmbuilder')
        expect(AlarmBuilder).to receive(:new).with(region: region).and_return(@copy)
        expect(@copy).to receive(:region).and_return(region)
        expect(@copy).to receive(:build_alarm).and_return(alarm)
      end

      it 'returns a JSON object with the alarm URL' do
        subject
        expect(JSON.parse(response.body)).to eq({"url" => "https://onebusaway.co/api/v1/regions/#{region.to_param}/alarms/#{alarm.to_param}"})
      end
    end
  end

  describe "DELETE /api/v1/regions/:region_id/alarms/:id" do
    skip
  end
end
