Rails.application.routes.draw do
  root to: 'regions#index'

  resources :regions, only: [:index, :show] do
    resources :alert_feeds, only: [:index, :show]
    resources :stops, only: [:show] do
      get 'arrivals'
      get 'trips'
    end
    resources :alarms, only: [:create, :destroy] do
      get 'callback'
    end
  end
end
