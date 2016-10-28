class RegionsController < ApplicationController

  def index
    @regions = Region.all
  end

  def show
    @region = Region.find_by(region_identifier: params[:id])
  end

  def site_association
    dict = {
      applinks: {
        apps: [],
        details: [
          {
            appID: "THEWY9596Q.org.onebusaway.iphone",
            paths: [ "*" ]
          }
        ]
      }
    }

    render json: dict
  end
end
