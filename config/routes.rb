require 'sidekiq/web'

class AdminConstraint
  def current_admin(request)
    @current_admin ||= Admin.find_by(session_token: request.cookies["session_token"].to_s) if !request.cookies["session_token"].blank?
  end

  def admin_logged_in?(request)
    !!current_admin(request)
  end

  def matches?(request)
    admin_logged_in?(request)
  end
end

Rails.application.routes.draw do
  root to: 'regions#index'

  mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new

  # Confusingly, the ids that are passed in to identify
  # regions are the id values present in the multiregion
  # file: http://regions.onebusaway.org/regions-v3.json
  # These values are referred to as `region_identifier`.
  #
  # The ids that exist locally, in Rails's DB, are
  # more or less unused.

  resources :alert_feeds, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :regions, only: [:index] do

        get 'vehicles', on: :member, defaults: {format: 'json'}

        # Weather
        resource :weather, only: [:show]

        # Stop Redirect/Trip Status
        resources :stops, only: [:show] do
          get 'trips'
        end

        # Alarms
        resources :alarms, only: [:create, :destroy]

        # Alerts
        resources :alerts, only: [:index], defaults: {format: 'pb'}
      end
    end
  end

  resource :admin, only: [:show, :update] do
    get 'activate', on: :member
    get 'reset_password', on: :member
    get 'alerts', on: :member
    get 'alarms', on: :collection
  end

  resources :alert_feed_items

  # Sessions
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get    '/logout',  to: 'sessions#destroy'

  # Old, unversioned API+HTML
  resources :regions, only: [:index, :show] do
    get 'agencies', on: :member
    resources :alert_feeds, only: [:index]
    resources :alert_feed_items, only: [:index] do
      get 'items', on: :collection
    end
    resources :stops, only: [:show] do
      get 'trips'
    end
    resources :alarms, only: [:create, :destroy]
  end
end
