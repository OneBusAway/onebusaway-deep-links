class AlertFeedItemsController < ApplicationController
  include AlertFeedItemsConcerns
  before_action :set_default_response_format

  def index
    region = Region.find_by(region_identifier: params[:region_id])
    @items = if region.nil?
      []
    else
      region.alert_feed_items.includes(:alert_feed).where(condition_filters(params)).limit(20)
    end
    
    respond_to do |format|
      format.json
    end
  end
  
  protected

  def set_default_response_format
    request.format = :json
  end
end