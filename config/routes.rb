Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'pages/:user_id', to: 'pages#user_show', as: :user_show

  resources :cakes, only: %i[index show new create edit update destroy] do
    resources :bookings, only: %i[create]
  end
  resources :bookings, only: %i[index show update destroy]
end
