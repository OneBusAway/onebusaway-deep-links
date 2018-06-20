class Api::V1::AlertsController < Api::V1::ApiController

  def index
    alerts = @region.alert_feed_items.includes(:alert_feed).order(published_at: :desc).limit(20)
    pb_message = GtfsMapper.alerts_to_pb_message(alerts, Time.now.to_i)
        
    respond_to do |format|
      format.json { render(json: pb_message.to_json) }
      format.pb { send_data(pb_message.serialize_to_string) }
      format.pbtext { render(plain: pb_message.text_format_to_string) }
    end
  end
end