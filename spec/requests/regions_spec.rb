require 'rails_helper'

describe Api::V1::RegionsController, type: :request do
  describe "GET /api/v1/regions" do
    before { @puget_sound = create_puget_sound_region! }
    before { get_json('/api/v1/regions') }

    it 'has HTTP status 200' do
      expect(response).to have_http_status 200
    end
    
    it 'has a JSON content-type' do
      expect(response.content_type).to eq("application/json")
    end

    it "returns a list of regions" do
      json = JSON.parse(response.body)
      parsed_body = [{"id"=>1,
        "name"=>"Puget Sound",
        "oba_api_url"=>"http://api.pugetsound.onebusaway.org/",
        "web_url"=>"http://pugetsound.onebusaway.org/",
        "weather_url"=>"http://www.example.com/api/v1/regions/1-puget-sound/weather",
        "path_templates" => {
          "stop_path" => "/api/v1/regions/1/stops/{id}",
          "trip_status_path" => "/api/v1/regions/1/stops/{stop_id}/trips{?trip_id,service_date,stop_sequence}"
        }
      }]
      expect(json).to eq(parsed_body)
    end
  end
end