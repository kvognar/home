Rails.application.routes.draw do
  
  root to: 'static_pages#home'
  get 'resume' => 'static_pages#resume', as: 'resume'
  get 'contact', to: 'static_pages#contact'

  get '/secrets' => 'sessions#new', as: 'secrets'
  post 'secrets' => 'sessions#create', as: 'login'
  delete 'secrets' => 'sessions#destroy', as: 'logout'

  resources :days, only: [:new, :index, :edit, :show] do
    resources :comments, only: :create, controller: 'api/comments'
  end
  get 'day_by_day', to: 'days#calendar'
  get 'susurrus', to: 'days#susurrus'
  get 'on_this_day', to: 'days#on_this_day'
  get 'your_song', to: 'days#your_song'
  get 'api_your_song', to: 'api/days#your_song'
  get 'people', to: 'tags#people'
  get 'feed', to: 'days#feed'

  resources :tags, only: [:show, :index]
  resources :comments, only: [:index, :update]
  get 'comments/rejected', to: 'comments#rejected', as: 'rejected_comments'

  namespace :api do
    resources :photos, only: :create
    resources :days, only: [:update, :create, :show]
    post 'migrate', to: 'migrations#migrate'
    put 'migrate/:number', to: 'migrations#update_migrate'
  end

  namespace :admin do
    resources :tags
    resources :quick_tags, only: [:show, :update]
  end

  get 'code/projects', to: 'code#projects'
  get 'code/games', to: 'code#games'
  get 'code/doodles', to: 'code#doodles'
  get 'code/games/bubble_booper',   to: 'code#bubble_booper', as: 'bubble_booper'
  get 'code/games/fall_from_grace', to: 'code#fall_from_grace', as: 'fall_from_grace'
  get 'code/games/platformer', to: 'code#platformer', as: 'platformer'
  get 'code/doodles/fairy', to: 'code#fairy', as: 'fairy'
  get 'code/doodles/unicorn', to: 'code#unicorn', as: 'unicorn'
  get 'code/doodles/dandelion', to: 'code#dandelion', as: 'dandelion'
  get 'code/doodles/jeffress_model', to: 'code#jeffress_model', as: 'sound_location'
  get 'code/doodles/tweetjam_sea', to: 'code#tweetjam_sea', as: 'tweetjam_sea'



end
