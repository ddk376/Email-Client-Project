Email::Application.routes.draw do
  root to: 'static_pages#root'

  resources :users, only: [:create, :new]
  resources :sessions, only: [:create, :new, :destroy]
end
