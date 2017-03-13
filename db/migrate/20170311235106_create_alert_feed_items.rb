class CreateAlertFeedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_feed_items do |t|
      t.integer :alert_feed_id, null: false
      t.string :title
      t.string :url
      t.text :summary
      t.datetime :published_at
      t.string :external_id

      t.timestamps
    end
  end
end
