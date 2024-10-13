require 'rails_helper'

RSpec.describe "Api::V1::Surveys", type: :request do
  describe "GET /index" do
    let(:region) { create(:region) }
    let(:study) { create(:study, region:) }
    let!(:active_survey) { create(:survey, study:, available: true, start_date: 2.day.ago, end_date: 1.day.from_now) }
    let!(:active_survey2) { create(:survey, study:, available: true, start_date: 1.day.ago, end_date: 1.day.from_now) }
    let!(:inactive_survey) { create(:survey, study:, available: false, start_date: 3.day.ago, end_date: 2.day.ago) }

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

    describe "returns only available surveys" do
      it "returns a list of surveys" do
        get api_v1_region_surveys_path(region, format: "json", user_id: 1)
        json_response = JSON.parse(response.body)
        expect(json_response["surveys"].length).to eq(3)
        expect(response.body).to include(active_survey.name)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
