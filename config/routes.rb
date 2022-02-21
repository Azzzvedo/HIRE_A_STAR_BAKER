Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :cakes, only: %i[index]
  end
  resources :cakes, only: %i[show new create edit update delete] do
    resources :bookings, only: %i[create]
  end
  resources :bookings, only: %i[index show update delete]
end
