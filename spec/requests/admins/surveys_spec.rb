require 'rails_helper'

RSpec.describe "Admins::StudyInvites", type: :request do
  let(:region) { create(:region) }
  let(:admin) { create(:admin, region:) }
  let(:study) { create(:study, region:) }

  describe "GET /new" do
    before { sign_in(admin) }
    it "returns a successful response" do
      get new_admin_study_survey_path(study)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before { sign_in(admin) }

    it "creates a new study invite" do
      sign_in(admin)

      # force the creation of a study invite
      expect(study.surveys.count).to eq(1)

      expect {
        post admin_study_surveys_path(study), params: { survey: attributes_for(:survey) }
      }.to change(Survey, :count).by(1)
    end

    it "redirects to the study invite" do
      post admin_study_surveys_path(study), params: { survey: attributes_for(:survey) }
      expect(response).to redirect_to(admin_study_survey_path(study, Survey.last))
    end
  end

  describe "GET /edit" do
    before { sign_in(admin) }

    it "returns a successful response" do
      get edit_admin_study_survey_path(study, study.surveys.first)
      expect(response).to be_successful
    end
  end

  describe "PUT /update" do
    before { sign_in(admin) }

    it "updates the requested study invite" do
      survey = study.surveys.first
      put admin_study_survey_path(study, survey), params: { survey: { name: 'New Name' } }
      survey.reload
      expect(survey.name).to eq('New Name')
    end

    it "redirects to the study invite" do
      survey = study.surveys.first
      put admin_study_survey_path(study, survey), params: { survey: { name: 'New Name' } }
      expect(response).to redirect_to(admin_study_survey_path(study, survey))
    end
  end

  describe "DELETE /destroy" do
    before { sign_in(admin) }

    let!(:survey) { create(:survey, study:) }

    it "destroys the requested study invite" do
      expect {
        delete admin_study_survey_path(study, survey)
      }.to change(Survey, :count).by(-1)
    end

    it "redirects to the study" do
      delete admin_study_survey_path(study, survey)
      expect(response).to redirect_to(admin_study_path(study))
    end
  end
end