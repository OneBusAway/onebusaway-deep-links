class Api::V1::SurveyResponsesController < Api::V1::ApiController
  skip_before_action :load_region
  def create
    @survey = Survey.find(params[:survey_id])
    @survey_response = @survey.survey_responses.build
    @survey_response.user_identifier = params[:user_identifier]

    responses = JSON.parse(params[:responses]).map { |r| SurveyResponseContent.new(r) }
    @survey_response.upsert_responses(responses)

    if @survey_response.save
      render 'create', status: :created, formats: :json
    else
      render_api_errors(@survey_response)
    end
  end

  def update
    # tk.
  end
end
