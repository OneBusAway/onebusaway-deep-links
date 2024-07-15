class Admins::SurveyResponsesController < ApplicationController
  before_action :admin_required
  before_action :load_resources

  def index
    @survey_responses = @survey.survey_responses.order(:created_at)
  end

  def show
    @survey_response = @survey.survey_responses.find_by(public_identifier: params[:id])
  end

  private

  def load_resources
    @survey = current_admin_region.surveys.find(params[:survey_id])
  end
end
