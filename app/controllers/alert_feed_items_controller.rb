class AlertFeedItemsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    # region = Region.find_by(region_identifier: params[:region_id])
    # @items = region.alert_feed_items.includes(:alert_feed).where(condition_filters(params)).limit(20)
    # respond_to do |format|
    #   format.json
    # end
    render json: []
  end
end