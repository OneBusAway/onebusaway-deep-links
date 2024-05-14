class Admins::AlarmsController < ApplicationController
  before_action :admin_required
  
  def index
    @region = current_admin.region
    @alarms = Alarm.order(created_at: :desc).includes(:region)
  end

  def show
    @alarm = Alarm.find(params[:id])

    server = @alarm.region.server
    key = "alarms/#{@alarm.id}/arrival_and_departure"

    @arr_dep = Rails.cache.fetch(key, expires_in: 30.seconds) do
      server.arrival_and_departure(stop_id: @alarm.stop_id, service_date: @alarm.service_date, stop_sequence: @alarm.stop_sequence, trip_id: @alarm.trip_id, vehicle_id: @alarm.vehicle_id)
    end
  end
end
