class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_region
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  include Api::V1::ErrorsHelper

  protected

  def load_region
    # due to the vagaries of the Rails routing API, sometimes our
    # parameter will be called region_id and sometimes id.
    region_id = params[:region_id] || params[:id]
    @region = Region.find_by!(region_identifier: region_id)
  rescue ActiveRecord::RecordNotFound => ex
    render_not_found_response("Couldn't find Region")
  end
end