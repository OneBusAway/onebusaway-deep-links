class CreateAlertFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_feeds do |t|
      t.string :name, null: false
      t.string :url
      t.datetime :last_fetched
      t.integer :region_id
      t.string :type

      t.timestamps
    end
  end
end
