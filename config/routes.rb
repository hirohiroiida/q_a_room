Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show,  :edit, :destroy] 
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show,  :edit, :destroy]
  end
end
