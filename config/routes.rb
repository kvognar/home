Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get 'resume' => 'static_pages#resume', as: 'resume'
  get '/platformer' => 'processing#platformer', as: 'platformer'
  resources :days, only: [:new, :create, :show, :index]
  resources :tags, only: :show

  namespace :api do
    resources :photos, only: :create
    resources :days, only: [:update, :create]
    post 'migrate', to: 'migrations#migrate'
  end
end
