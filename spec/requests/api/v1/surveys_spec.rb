require 'rails_helper'

RSpec.describe "Api::V1::Surveys", type: :request do
  describe "GET /index" do
    let(:region) { create(:region) }

    describe "when user_id is blank" do
      it "returns an error message" do
        get api_v1_region_surveys_path(region, format: "json")
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("user_id is required")
      end
    end

    describe "when user_id is present" do
      it "returns a list of surveys" do
        get api_v1_region_surveys_path(region, format: "json", user_id: 1)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
