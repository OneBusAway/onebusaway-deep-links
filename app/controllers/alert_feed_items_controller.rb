class AlertFeedItemsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    # :-\ this is the result of a dumb decision i made here: 
    # https://github.com/OneBusAway/onebusaway-deep-links/commit/8df90ceb7367e78ebe489421ac268b663dca69d9
    # now I need to hack around it by keeping this action as-is for backwards compatibility reasons for now.
    request.format = :json
    
    load_index_data
    
    respond_to do |format|
      format.json
    end
  end
  
  def items
    load_index_data
    respond_to do |format|
      format.html {render(layout: 'regions')}
    end
  end
    
  protected

  def load_index_data
    @region = Region.find_by(region_identifier: params[:region_id])
    @items = if @region.nil?
      []
    else
      @region.alert_feed_items.includes(:alert_feed).where(condition_filters(params)).limit(20)
    end
  end
end