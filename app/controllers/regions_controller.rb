class RegionsController < ApplicationController

  def index
    @regions = Region.all
  end

  def show
    @region = Region.find(params[:id])
  end

  def site_association
    @regions = Region.all
    # render json: @regions.to_json
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
