Email::Application.routes.draw do
  root to: 'static_pages#root'

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :sent_threads, only: [:index] do
      resources :emails, only: [:create]
    end
    resources :inbox_threads, only: [:index] do
      resources :emails, only: [:create]
    end
    resources :draft_threads, only: [:index] do
      resources :emails, only: [ :edit, :update]
    end
    resources :starred_threads, only: [:index]
    resources :important_threads, only: [:index]
    resources :all_threads, only: [:index]
    resources :spam_threads, only: [:index]
    resources :trash_threads, only: [:index]

    resources :email_threads, only: [:show, :update, :new, :create]

    resources :emails, only: [:show, :update, :new, :create] do
      resources :emails, only: [:index]
    end

  end
end
