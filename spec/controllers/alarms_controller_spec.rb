require 'rails_helper'

RSpec.describe AlarmsController, type: :controller do
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
  end
end
