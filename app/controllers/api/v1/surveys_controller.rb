# app/controllers/api/v1/surveys_controller.rb
class Api::V1::SurveysController < Api::V1::ApiController
  before_action :load_region

  def index
    if params[:user_id].blank?
      render_api_errors(message: 'user_id is required')
      return
    end


    @surveys = Survey.includes(:study).filter_currently_active
                     .where(available: true, studies: { region: @region })
  end

  private

  def load_region
    @region = Region.find_by(region_identifier: params[:region_id])
  end
end
