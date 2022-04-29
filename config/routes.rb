Rails.application.routes.draw do
  root to: 'questions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :new, :create, :show,  :edit] 
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :questions, only: [:index, :show, :destroy] do
      resources :answers, only: [:create, :destroy]
    end
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end

  resources :questions do
    collection do
      get :solved
      get :unsolved
    end

    member do
      post :solve
    end
    resources :answers, only: [:create, :destroy]
  end




end
