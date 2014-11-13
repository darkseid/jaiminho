require 'sidekiq/web'

Rails.application.routes.draw do

  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :email_templates
  resources :email_reports, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    resources :emails
  end

end
