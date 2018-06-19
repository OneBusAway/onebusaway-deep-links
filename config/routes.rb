Rails.application.routes.draw do
  root to: 'regions#index'

  resources :alert_feeds, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index] do
        
        # Weather
        resource :weather, only: [:show]
        
        # Stop Redirect/Trip Status
        resources :stops, only: [:show] do
          get 'trips'
        end
        
        # Alarms
        resources :alarms, only: [:create, :destroy] do
          get 'callback'
        end
        
      end
    end
  end

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
    resources :alert_feed_items, only: [:index] do
      get 'items', on: :collection
    end
    resources :stops, only: [:show] do
      get 'trips'
    end
    resources :alarms, only: [:create, :destroy] do
      get 'callback'
    end
  end
end
