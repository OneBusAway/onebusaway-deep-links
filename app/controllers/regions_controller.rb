class RegionsController < ApplicationController
  before_action :admin_required, except: %i[index show agencies]

  def index
    @regions = Region.order(region_identifier: :asc)
    respond_to do |format|
      format.html { render(layout: 'application') }
    end
  end

  def show
    @region = Region.find_by!(region_identifier: params[:id])
  end

  def validate
    @region = Region.find_by!(region_identifier: params[:id])
    @validator = ServerValidator.new(@region.api_url)
    @validator.run
  end

  def agencies
    @region = Region.find_by!(region_identifier: params[:id])
  end
end
