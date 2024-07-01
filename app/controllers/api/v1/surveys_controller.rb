class Api::V1::SurveysController < ApplicationController
  before_action :load_region

  def index
    @surveys = Survey.includes(:study).where(available: true, studies: { region: @region })
  end

  private

  def load_region
    @region = Region.find(params[:region_id])
  end
end
