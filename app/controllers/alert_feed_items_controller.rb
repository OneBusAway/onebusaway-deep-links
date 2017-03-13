class AlertFeedItemsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    region = Region.find_by(region_identifier: params[:region_id])
    items = region.alert_feed_items.where(condition_filters(params)).limit(20)
    render json: items.to_json
  end
end