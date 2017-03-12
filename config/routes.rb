Rails.application.routes.draw do
  root to: 'regions#index'

  resources :alert_feeds, only: [:show]
  resources :regions, only: [:index, :show] do
    resources :alert_feeds, only: [:index]
    resources :alert_feed_items, only: [:index]
    resources :stops, only: [:show] do
      get 'arrivals'
      get 'trips'
    end
    resources :alarms, only: [:create, :destroy] do
      get 'callback'
    end
  end
end
