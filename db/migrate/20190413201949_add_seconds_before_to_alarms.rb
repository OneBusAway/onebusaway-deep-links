class AddSecondsBeforeToAlarms < ActiveRecord::Migration[5.2]
  def change
    add_column :alarms, :seconds_before, :integer, null: false, default: 600
  end
end