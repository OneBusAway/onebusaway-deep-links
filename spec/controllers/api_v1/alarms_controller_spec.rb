require 'rails_helper'

RSpec.describe Api::V1::AlarmsController, type: :controller do
  let(:region) { create_puget_sound_region! }

  describe '#destroy' do
    context 'when an alarm exists' do

      before do
        @alarm = region.alarms.create!(message: "message", push_identifier: "pushid_123", stop_id: "stopid_123", trip_id: "tripid_123", service_date: 1234567890, vehicle_id: "vehicle_123", stop_sequence: 1, seconds_before: 300)
      end

      describe "when passing in an invalid alarm token" do
        before do
          delete(:destroy, params: {region_id: region.region_identifier, id: 'xyz'})
        end

        it "does not delete the existing alarm" do
          expect(Alarm.count).to eq(1)
        end
        it "returns status OK" do
          expect(response).to be_ok
        end
      end

      describe "when passing in a valid alarm token" do
        before do
          delete(:destroy, params: {region_id: region.region_identifier, id: @alarm.secure_token})
        end
        it "deletes the existing alarm" do
          expect(Alarm.count).to eq(0)
        end
        it "returns status OK" do
          expect(response).to be_ok
        end
      end
    end
  end

  describe '#create' do
    context 'with an unknown region id' do
      before do
        post(:create, params: {"region_id": "99", "seconds_before": "600", "service_date": "0", "stop_id": "312_30832",
  "stop_sequence": "52", "trip_id": "312_396972.5", "user_push_id": "5c2fd7dd-23cd-4c5d-84b0-1ce7576e27a2", "vehicle_id": "" })
      end

      it 'returns status 404' do
        expect(response.status).to eq(404)
      end

      it 'has a json body with an error message' do
        expect(JSON.parse(response.body)).to eq({ "error" => "Couldn't find Region" })
      end
    end

    context 'in Puget Sound' do
      before do
        expect(Alarm.count).to eq(0)

        json_text = <<~HEREDOC
                    {
                      "currentTime": 1234567890,
                      "data": {
                        "entry": {
                          "name_with_headsign": "GET ON THE BUS"
                        }
                      }
                    }
                    HEREDOC

        response = double("response")
        expect(response).to receive(:body).at_least(:once) { json_text }

        expect(RestClient).to receive(:get).with(/http:\/\/api.pugetsound.onebusaway.org\/api\/where\/arrival-and-departure-for-stop\/312_30832.json/) { response }

        post(:create, params: {
            "region_id": region.region_identifier,
            "seconds_before": "600",
            "service_date": "0",
            "stop_id": "312_30832",
            "stop_sequence": "52",
            "trip_id": "312_396972.5",
            "user_push_id": "5c2fd7dd-23cd-4c5d-84b0-1ce7576e27a2",
            "vehicle_id": ""
          })
      end

      it 'creates an alarm' do
        expect(Alarm.count).to eq(1)
      end

      it 'returns status 200' do
        expect(response.status).to eq(200)
      end

      it 'returns a JSON body containing the URL for the alarm' do
        json = JSON.parse(response.body)
        url = json["url"]
        expect(url).to match(/http:\/\/test\.host\/regions\/1-puget-sound\/alarms\/.*/)
      end
    end
  end
end