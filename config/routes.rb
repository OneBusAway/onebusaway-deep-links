Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'regions#index'

  resources :regions, only: [:index, :show] do
    resources :stops, only: [:show] do
      get 'arrivals'
      get 'trips'
    end
    resources :alarms, only: [:create, :destroy] do
      get 'notification_callback', on: :collection
    end
  end

  get 'apple-app-site-association', to: 'regions#site_association', defaults: { format: 'json' }
end
