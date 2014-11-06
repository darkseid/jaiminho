require 'sidekiq/web'

Rails.application.routes.draw do

  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :email_templates

  namespace :api, defaults: { format: "json" } do
    resources :emails do
      collection do
        get 'forward'
      end
    end
  end

end
