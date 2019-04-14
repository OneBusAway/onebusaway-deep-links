class AlarmsController < ApplicationController
  include AlarmsConcerns
  before_action :load_region
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    create_alarm_in_region(region: @region, params: params)
  end

  def destroy
    destroy_alarm_with_token(params[:id], @region)
  end

  protected

  def load_region
    @region = Region.find_by!(region_identifier: params[:region_id])
  end
end
