class AddIndexesToAlertFeeds < ActiveRecord::Migration[5.0]
  def change
    add_index :alert_feeds, :url, unique: true
    add_index :alert_feeds, :region_id
    add_index :alert_feed_items, :alert_feed_id
  end
end
