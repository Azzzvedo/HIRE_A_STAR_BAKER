Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :cakes, only: %i[index]
  end
  resources :cakes do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[index show update delete]
end
