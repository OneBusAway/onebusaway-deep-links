class AlertFeedsController < ApplicationController
  def index
    feeds = AlertFeed.where(region_id: params[:region_id])
    render json: feeds.to_json
  end

  def show
    feed = AlertFeed.find(params[:id])

    options = {}
    if params[:since].present?
      options[:published_at] = Time.at(params[:since].to_i).to_datetime..Time.now
    end

    render json: feed.alert_feed_items.where(options).to_json
  end
end
