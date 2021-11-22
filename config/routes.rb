Rails.application.routes.draw do
  root 's3files#home'
  resources :users do
    resources :channels
  end
  get 's3files/home', to: 's3files#home'
  get 's3files/music', to: 's3files#music'
  get 's3files/movie', to: 's3files#movie'
  get 's3files/program', to: 's3files#program'
  get 's3files/game', to: 's3files#game'
  get 's3files/news', to: 's3files#news'
  get 's3files/sports', to: 's3files#sports'
  get 's3files/learning', to: 's3files#learning'
  resources :s3files
  resources :comments
  resources :sessions, only: %i[create]
end
