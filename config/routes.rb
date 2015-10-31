Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get 'resume' => 'static_pages#resume', as: 'resume'
  get '/platformer' => 'processing#platformer', as: 'platformer'
  resources :days, only: [:new, :create, :show, :index]

  namespace :api do
    post 'migrate', to: 'days#migrate'
  end
end
