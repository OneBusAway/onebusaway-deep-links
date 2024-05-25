class OneSignal
  attr_accessor :api_key
  attr_accessor :app_id

  ONE_SIGNAL_API_NOTIFICATIONS_URL = 'https://onesignal.com/api/v1/notifications'.freeze

  def self.client
    OneSignal.new(
      Rails.application.credentials.dig(:onesignal, :api_key),
      Rails.application.credentials.dig(:onesignal, :app_id)
    )
  end

  def initialize(api_key, app_id)
    raise "Unable to start Push Client" if api_key.blank? || app_id.blank?

    self.api_key = api_key
    self.app_id = app_id
  end

  def send_message(user_id, alarm)
    params = {
      app_id: self.app_id,
      contents: {
        en: alarm.message,
      },
      data: {
        arrival_and_departure: {
          region_id: alarm.region_id,
          stop_id: alarm.stop_id,
          trip_id: alarm.trip_id,
          service_date: alarm.service_date,
          vehicle_id: alarm.vehicle_id,
          stop_sequence: alarm.stop_sequence
        }
      },
      mutable_content: true,
      include_player_ids: [user_id]
    }
    uri = URI.parse(ONE_SIGNAL_API_NOTIFICATIONS_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{self.api_key}")
    request.body = params.as_json.to_json
    response = http.request(request)
    puts response.body
  end
end