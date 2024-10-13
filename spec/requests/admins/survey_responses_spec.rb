require 'rails_helper'

RSpec.describe "Admins::SurveyResponses", type: :request do
  describe "GET /index" do
    let(:region) { create(:region) }
    let(:admin) { create(:admin, region:) }
    let(:study) { create(:study, region:) }
    let(:survey) { create(:survey, study:) }

    before do
      sign_in admin
      @response_with_location = create(:survey_response, survey:, stop_latitude: 1.0, stop_longitude: 1.0, stop_identifier: 'stop_123')
      @response_without_location = create(:survey_response, survey:, stop_latitude: nil, stop_longitude: nil, stop_identifier: nil)
    end

    it 'renders the index template' do
      get admin_study_survey_survey_responses_path(study, survey)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    it 'checks the values of the survey responses' do
      expect(@response_with_location.stop_latitude).to eq(1.0)
      expect(@response_with_location.stop_longitude).to eq(1.0)
      expect(@response_with_location.stop_identifier).to eq('stop_123')

      expect(@response_without_location.stop_latitude).to be_nil
      expect(@response_without_location.stop_longitude).to be_nil
      expect(@response_without_location.stop_identifier).to be_nil
    end
  end
end