class AddManualFeedIdToRegion < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :manual_feed_id, :integer
    add_index :regions, :manual_feed_id
    
    Region.reset_column_information
    
    puget_sound = Region.find_by(region_identifier: 1)
    manual_feed = puget_sound.alert_feeds.find_by(type: 'PugetSoundManualAlertFeed')
    puget_sound.manual_feed = manual_feed
    puget_sound.save!
  end
end