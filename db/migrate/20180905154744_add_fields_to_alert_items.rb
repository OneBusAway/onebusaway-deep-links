class AddFieldsToAlertItems < ActiveRecord::Migration[5.2]
  def change
    add_column :alert_feed_items, :test_item, :boolean, null: false, default: true
    
    rename_column :alert_feed_items, :published_at, :starts_at
    add_column :alert_feed_items, :ends_at, :datetime
    
    # 0 for cause == Unknown
    # 7 for effect == Unknown :-\
    add_column :alert_feed_items, :cause, :integer, null: false, default: 0
    add_column :alert_feed_items, :effect, :integer, null: false, default: 7
  end
end