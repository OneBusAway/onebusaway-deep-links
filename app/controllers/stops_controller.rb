class StopsController < ApplicationController

  def show
    @region = Region.find(params[:region_id])

    # TODO: needs special handling
    # Washington DC - Region API ID: 4
    # York - Region API ID: 5
    # Bear Transit - Region API ID: 6

    # Not handled currently:
    # MTA New York - Region API ID 2

    redirect_to File.join(@region.web_url, "/where/standard/stop.action?id=#{params[:id]}")
  end
end
