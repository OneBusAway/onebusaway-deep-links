require 'rails_helper'

describe Api::V1::WeatherController, type: :request do
  let(:puget_sound) { create_puget_sound_region! }

  def expect_response_to_offer_weather_for_location(lat,lon)
    expect(json.keys).to eq(["latitude", "longitude", "region_identifier", "region_name", "retrieved_at", "units", "today_summary", "current_forecast", "hourly_forecast"])
    expect(json['latitude']).to eq(lat)
    expect(json['longitude']).to eq(lon)
    expect(json['region_identifier']).to eq(1)
    expect(json['region_name']).to eq('Puget Sound')
    expect(json['retrieved_at']).to_not be_nil
    expect(json['units']).to eq('us')
    expect(json['today_summary']).to eq('Cloudy')
    expect(json['current_forecast'].keys).to eq(["icon", "precip_per_hour", "precip_probability", "summary", "temperature", "temperature_feels_like", "time", "wind_speed"])
    expect(json['current_forecast']['icon']).to eq('partly-cloudy-day')
  end

  describe "GET /api/v1/regions/{region_id}/weather" do
    before do
      VCR.use_cassette('weather_puget_sound') do
        get_json("/api/v1/regions/#{puget_sound.region_identifier}/weather")
      end
    end

    it { has_status_code(200) }
    it { returns_json }

    it 'returns weather information for the region' do
      expect_response_to_offer_weather_for_location(47.63671875, -122.6953125)
    end
  end

  describe "GET /api/v1/regions/{region_id}/weather?lat=LAT_VAL&lon=LON_VAL" do
    xit
  end
end