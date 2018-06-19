require 'rails_helper'

describe Api::V1::RegionsController, type: :request do
  describe "GET /api/v1/regions" do
    before do
      @puget_sound = create_puget_sound_region!
      get_json('/api/v1/regions')
    end

    it { has_status_code(200) }    
    it { returns_json }

    it "returns a list of regions" do
      json = JSON.parse(response.body)
      parsed_body = [{"id"=>1,
        "name"=>"Puget Sound",
        "oba_api_url"=>"http://api.pugetsound.onebusaway.org/",
        "web_url"=>"http://pugetsound.onebusaway.org/",
        "weather_url"=>"http://www.example.com/api/v1/regions/1-puget-sound/weather",
        "path_templates" => {
          "stop_path" => "/api/v1/regions/1/stops/{id}",
          "trip_status_path" => "/api/v1/regions/1/stops/{stop_id}/trips{?trip_id,service_date,stop_sequence}",
          "weather_path" => "/api/v1/regions/1/weather{?lat,lon}"
        }
      }]
      expect(json).to eq(parsed_body)
    end
  end
end