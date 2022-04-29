Rails.application.routes.draw do
  root to: 'questions#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: %i[index new create show edit]
  namespace :admin do
    resources :users, only: %i[index show destroy]
    resources :questions, only: %i[index show destroy] do
      resources :answers, only: %i[create destroy]
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
    resources :answers, only: %i[create destroy]
  end
end
