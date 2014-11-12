require 'sidekiq/web'

Rails.application.routes.draw do

  apipie
  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :email_templates

  namespace :api, defaults: { format: 'json' } do
    resources :emails
  end

end
