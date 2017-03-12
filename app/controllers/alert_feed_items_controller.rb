class AlertFeedItemsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    region = Region.find(params[:region_id])
    items = region.alert_feed_items.where(condition_filters(params))
    render json: items.to_json
  end
end