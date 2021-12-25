Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :questions, except: %i[show index]

  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'
end
