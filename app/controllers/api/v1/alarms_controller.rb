class Api::V1::AlarmsController < Api::V1::ApiController
  include AlarmsConcerns
  before_action :load_region
  
  def create
    create_alarm_in_region(@region)
  end

  def destroy
    destroy_alarm_with_token(params[:id], @region)
  end
    
  def callback
    perform_callback_for_alarm_id(params[:alarm_id], @region)
  end

  protected

  def load_region
    @region = Region.find_by(region_identifier: params[:region_id])
  end
end