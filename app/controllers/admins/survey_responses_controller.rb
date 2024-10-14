class Admins::SurveyResponsesController < ApplicationController
  before_action :admin_required
  before_action :load_resources

  def index
    @survey_responses = @survey.survey_responses.order(:created_at)

    respond_to do |format|
      format.html do
        @pagy, @survey_responses = pagy(@survey_responses)
      end
      format.csv do
        filename = generate_filename(@survey)
        send_data SurveyResponse.to_csv(@survey_responses), filename:, content_type: 'text/csv'
      end
    end
  end

  def show
    @survey_response = @survey.survey_responses.find_by(public_identifier: params[:id])
  end

  private

  def load_resources
    @survey = current_admin_region.surveys.find(params[:survey_id])
  end

  # Helper method to generate CSV filename
  def generate_filename(survey)
    study_name = survey.study.name.parameterize(separator: '_')
    survey_name = survey.name.parameterize(separator: '_')
    date = Date.today.to_s
    "study_#{study_name}_survey_#{survey_name}_responses_#{date}.csv"
  end
end
