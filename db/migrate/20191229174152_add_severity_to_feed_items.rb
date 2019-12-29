class AddSeverityToFeedItems < ActiveRecord::Migration[5.2]
  def change
    add_column :alert_feed_items, :severity, :integer, default: 1
  end
end