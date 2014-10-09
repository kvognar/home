Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get '/platformer' => 'processing#platformer', as: 'platformer'
end
