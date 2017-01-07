class OneSignal
  
  attr_accessor :api_key
  attr_accessor :app_id
  
  ONE_SIGNAL_API_NOTIFICATIONS_URL = 'https://onesignal.com/api/v1/notifications'.freeze
    
  def initialize(api_key, app_id)
    self.api_key = api_key
    self.app_id = app_id
  end
  
  
  def send_message(user_id, message)
    params = {
      app_id: self.app_id,
      contents: {
        en: message
      },
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