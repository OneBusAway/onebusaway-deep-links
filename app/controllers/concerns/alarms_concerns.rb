module AlarmsConcerns
  extend ActiveSupport::Concern

  def alarm_builder
    @alarm_builder ||= AlarmBuilder.new(region: @region)
  end

  def create_alarm(params:)
    alarm = alarm_builder.build_alarm(params: params)
    json_response = if alarm.save
      {json: {url: region_alarm_url(alarm_builder.region, alarm)}}
    else
      {json: {error: "Unable to register alarm", messages: alarm.errors.full_messages}, status: response.status}
    end

    render(json_response)
  end

  def destroy_alarm_with_token(token, region)
    alarm = region.alarms.find_by(secure_token: token)
    alarm.destroy unless alarm.nil?
    head :ok
  end
end