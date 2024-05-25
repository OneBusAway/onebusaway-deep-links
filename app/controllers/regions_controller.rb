class RegionsController < ApplicationController
  def index
    @regions = Region.order(region_identifier: :asc)
    respond_to do |format|
      format.html { render(layout: 'application') }
    end
  end

  def show
    @region = Region.find_by!(region_identifier: params[:id])
  end

  def agencies
    @region = Region.find_by!(region_identifier: params[:id])
  end
end
