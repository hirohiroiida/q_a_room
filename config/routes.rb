Rails.application.routes.draw do
  get 'questions/index'
  get 'questions/new'
  get 'questions/show'
  get 'questions/edit'
  root to: 'users#index'

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
end
