Rails.application.routes.draw do
  
  root to: 'static_pages#index'
  get '/platformer' => 'processing#platformer', as: 'platformer'
end
