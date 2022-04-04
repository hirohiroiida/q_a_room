Rails.application.routes.draw do
  root to: 'questions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :new, :create, :show,  :edit, :destroy] 
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show,  :edit, :destroy]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  resources :questions do
    resources :answers, only: [:create, :destroy]
  end




end
