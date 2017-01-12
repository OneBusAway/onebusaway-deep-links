class RegionsController < ApplicationController

  def index
    @regions = Region.all
  end

  def show
    @region = Region.find_by(region_identifier: params[:id])
  end
end
