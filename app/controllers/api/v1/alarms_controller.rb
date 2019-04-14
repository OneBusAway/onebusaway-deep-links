class Api::V1::AlarmsController < Api::V1::ApiController
  include AlarmsConcerns

  def create
    record_pageview(@region, 'alarms')

    create_alarm_in_region(region: @region, params: params)
  end

  def destroy
    destroy_alarm_with_token(params[:id], @region)
  end
end