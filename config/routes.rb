Email::Application.routes.draw do
  root to: 'static_pages#root'

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :sent_threads do
      resources :emails, only: [:create]
    end
    resources :inbox_threads do
      resources :emails, only: [:create]
    end
    resources :starred_threads
    resources :important_threads
    resources :draft_threads do
      resources :emails, only: [:edit, :update]
    end
    resources :all_threads
    resources :spam_threads
    resources :trash_threads
  end
end
