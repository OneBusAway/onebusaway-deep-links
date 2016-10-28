class StopsController < ApplicationController

  def show
    @region = Region.find(params[:region_id])
    redirect_to File.join(@region.web_url, "/where/standard/stop.action?id=#{params[:id]}")
  end
end
