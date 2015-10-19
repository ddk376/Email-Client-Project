Email::Application.routes.draw do
  root to: 'static_pages#root'

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :inbox_threads, only: [:index, :show, :update]
    resources :sent_threads, only: [:index, :show, :update]
    resources :draft_threads, only: [:index, :show, :update]
    resources :starred_threads, only: [:index, :show, :update]
    resources :important_threads, only: [:index, :show, :update]
    resources :trash_threads, only: [:index, :show, :update, :destroy]
    resources :all_threads, only: [:index, :show, :update]
    resources :spam_threads, only: [:index, :show, :update]
    resources :email, only: [:create, :destroy, :edit, :update, :show]
  end
end
