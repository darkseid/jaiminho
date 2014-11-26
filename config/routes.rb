require 'sidekiq/web'

Rails.application.routes.draw do

  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :email_templates
  resources :email_requests, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      resources :email_requests, only: [:create]
    end
  end

end
