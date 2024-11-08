require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "employees#index"

  mount Sidekiq::Web => '/sidekiq'

  resources :employees, only: [:index,:new, :create, :edit, :update]
end
