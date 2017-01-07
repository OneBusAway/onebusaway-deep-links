class CreateAlarms < ActiveRecord::Migration[5.0]
  def change
    create_table :alarms do |t|
      t.integer :region_id
      t.string :alarm_identifier
      t.string :push_identifier
      t.string :message
      t.string :secure_token
      t.timestamps
    end
    add_index :alarms, :region_id
    add_index :alarms, :alarm_identifier
    add_index :alarms, :push_identifier
    add_index :alarms, :secure_token, unique: true
  end
end
