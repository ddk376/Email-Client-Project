Email::Application.routes.draw do
  root to: 'static_pages#root'

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :email_threads do
      resources :emails, only: [:create]
    end
  end
end
