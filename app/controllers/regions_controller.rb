class RegionsController < ApplicationController

  def index
    @regions = Region.all
  end

  def show
    @region = Region.find(params[:id])
  end

  def site_association
    @regions = Region.all

    render json: @regions.to_json
  end
end
