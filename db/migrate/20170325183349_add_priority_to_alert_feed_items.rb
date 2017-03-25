class AddPriorityToAlertFeedItems < ActiveRecord::Migration[5.0]
  def change
    add_column :alert_feed_items, :priority, :integer, default: 0
  end
end