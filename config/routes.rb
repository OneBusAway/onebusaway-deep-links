Rails.application.routes.draw do
  root to: 'regions#index'

  resources :alert_feeds, only: [:show]

  # Confusingly, the ids that are passed in to identify
  # regions are the id values present in the multiregion
  # file: http://regions.onebusaway.org/regions-v3.json
  # These values are referred to as `region_identifier`.
  #
  # The ids that exist locally, in Rails's DB, are
  # more or less unused.
  resources :regions, only: [:index, :show] do
    resource :weather, only: [:show]
    resources :alert_feeds, only: [:index]
    resources :alert_feed_items, only: [:index]
    resources :stops, only: [:show] do
      get 'trips'
    end
    resources :alarms, only: [:create, :destroy] do
      get 'callback'
    end
  end
end
