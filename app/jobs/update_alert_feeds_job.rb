class UpdateAlertFeedsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AlertFeed.find_each do |feed|
      feed.fetch_if_necessary
    end
  end
end
