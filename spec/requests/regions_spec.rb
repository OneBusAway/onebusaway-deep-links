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
        "path_templates" => {
          "create_alarm_path" => "/api/v1/regions/1-puget-sound/alarms",
          "alerts_path" => "/api/v1/regions/1-puget-sound/alerts",
          "stop_path" => "/api/v1/regions/1-puget-sound/stops/{id}",
          "trip_status_path" => "/api/v1/regions/1-puget-sound/stops/{stop_id}/trips{?trip_id,service_date,stop_sequence}",
          "weather_path" => "/api/v1/regions/1-puget-sound/weather{?lat,lon}"
        }
      }]
      expect(json).to eq(parsed_body)
    end
  end
  
  describe "GET /api/v1/regions/:id/vehicles", vcr: { cassette_name: "get_api_v1_region_vehicles" } do
    before do
      @puget_sound = create_puget_sound_region!
      get_json(vehicles_api_v1_region_path(@puget_sound, query: '224'))
    end
    
    it { has_status_code(200) }    
    it { returns_json }
    
    it "returns a list of active vehicle IDs" do
      json = JSON.parse(response.body)
      expect(json).to eq([{"id"=>"98", "name"=>"Seattle Childrens Hospital", "vehicle_id"=>"98_224"}])
    end
  end
end