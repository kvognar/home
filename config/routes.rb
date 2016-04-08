Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get 'resume' => 'static_pages#resume', as: 'resume'
  get '/platformer' => 'processing#platformer', as: 'platformer'

  get '/secrets' => 'sessions#new', as: 'secrets'
  post 'secrets' => 'sessions#create', as: 'login'
  delete 'secrets' => 'sessions#destroy', as: 'logout'

  resources :days, only: [:new, :create, :index, :edit, :show] do
    resources :comments, only: :create, controller: 'api/comments'
  end
  get 'day_by_day', to: 'days#calendar'
  get 'feed', to: 'days#feed'

  resources :tags, only: :show
  resources :comments, only: [:index, :update]

  namespace :api do
    resources :photos, only: :create
    resources :days, only: [:update, :create]
    post 'migrate', to: 'migrations#migrate'
    put 'migrate/:number', to: 'migrations#update_migrate'
  end
end
