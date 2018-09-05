class AddFieldsToAlertItems < ActiveRecord::Migration[5.2]
  def change
    add_column :alert_feed_items, :test_item, :boolean, null: false, default: false
    
    rename_column :alert_feed_items, :published_at, :starts_at
    add_column :alert_feed_items, :ends_at, :datetime
    
    # 1 for cause == Unknown
    # 8 for effect == Unknown :-\
    add_column :alert_feed_items, :cause, :integer, null: false, default: 1
    add_column :alert_feed_items, :effect, :integer, null: false, default: 8
  end
end