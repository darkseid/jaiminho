require_relative "../lib/api_constraints"

require 'sidekiq/web'

Rails.application.routes.draw do

  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :email_templates
  resources :email_requests, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :email_requests, only: [:create]
    end
  end

end
