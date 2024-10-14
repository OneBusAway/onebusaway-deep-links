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

    it "creates a new survey" do
      sign_in(admin)

      # force the creation of a survey
      expect(study.surveys.count).to eq(1)

      expect do
        post admin_study_surveys_path(study), params: { survey: attributes_for(:survey) }
      end.to change(Survey, :count).by(1)
    end

    it "redirects to the survey" do
      post admin_study_surveys_path(study), params: { survey: attributes_for(:survey) }
      expect(response).to redirect_to(admin_study_survey_path(study, Survey.last))
    end

    it "does not create a new survey when end_date is before start_date" do
      expect do
        post admin_study_surveys_path(study), params: { survey: attributes_for(:survey, :invalid_end_date_before_start_date) }
      end.to change(Survey, :count).by(1)
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

    let(:current_time) { Time.current }

    it "updates the requested survey" do
      survey = study.surveys.first
      new_start_date = 1.day.from_now.change(usec: 0)
      new_end_date = 2.days.from_now.change(usec: 0)

      put admin_study_survey_path(study, survey),
          params: {
            survey: {
              name: 'New Name',
              start_date: new_start_date,
              end_date: new_end_date
            }
          }

      survey.reload

      expect(survey.name).to eq('New Name')
      expect(survey.start_date.change(usec: 0)).to eq(new_start_date)
      expect(survey.end_date.change(usec: 0)).to eq(new_end_date)
    end

    it "redirects to the survey" do
      survey = study.surveys.first
      put admin_study_survey_path(study, survey), params: { survey: { name: 'New Name' } }
      expect(response).to redirect_to(admin_study_survey_path(study, survey))
    end
  end

  describe "DELETE /destroy" do
    before { sign_in(admin) }

    let!(:survey) { create(:survey, study:) }

    it "destroys the requested survey" do
      expect do
        delete admin_study_survey_path(study, survey)
      end.to change(Survey, :count).by(-1)
    end

    it "redirects to the study" do
      delete admin_study_survey_path(study, survey)
      expect(response).to redirect_to(admin_study_path(study))
    end
  end
end
