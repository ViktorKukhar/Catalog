Rails.application.routes.draw do
  resources :records
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  get 'users/:id/profile', to: 'users#profile', as: 'user_profile'


  # Defines the root path route ("/")
  root "public#index"
end
