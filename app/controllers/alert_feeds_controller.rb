class AlertFeedsController < ApplicationController
  include AlertFeedItemsConcerns

  def index
    region = Region.find_by(region_identifier: params[:region_id])
    feeds = region.alert_feeds
    render json: feeds.to_json
  end

  def show
    feed = AlertFeed.find(params[:id])
    render json: feed.alert_feed_items.where(condition_filters(params)).to_json
  end
end
