class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_region
  
  protected
  
  def load_region
    @region = Region.find_by!(region_identifier: params[:region_id])
  end
end