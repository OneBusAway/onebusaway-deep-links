class MorePushFields < ActiveRecord::Migration[5.0]
  def change
    add_column :alarms, :stop_id, :string
    add_column :alarms, :trip_id, :string
    add_column :alarms, :service_date, :bigint
    add_column :alarms, :vehicle_id, :string
    add_column :alarms, :stop_sequence, :integer
    remove_column :alarms, :alarm_identifier
  end
end