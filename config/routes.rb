Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :regions, only: [:index, :show]
  get 'apple-app-site-association', to: 'regions#site_association', defaults: { format: 'json' }
end
