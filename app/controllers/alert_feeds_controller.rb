class AlertFeedsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    feeds = AlertFeed.where(region_id: params[:region_id])
    render json: feeds.to_json
  end

  def show
    feed = AlertFeed.find(params[:id])
    render json: feed.alert_feed_items.where(condition_filters(params)).to_json
  end
end
