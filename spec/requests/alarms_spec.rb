require 'rails_helper'

# abxoxo - todo fill me in!

describe Api::V1::AlarmsController, type: :request do

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
      xit
    end
  end
  
  describe "DELETE /api/v1/regions/:region_id/alarms/:id" do
    skip
  end
  
  describe "GET /api/v1/regions/:region_id/alarms/:id/callback" do
    skip
  end
end
