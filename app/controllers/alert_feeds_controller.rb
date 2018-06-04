class AlertFeedsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    region = Region.find_by(region_identifier: params[:region_id])
    feeds = region.alert_feeds
    
    respond_to do |format|
      format.json { render(json: feeds.to_json) }
    end    
  end
end
