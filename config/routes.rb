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
  post 's3files/search', to: 's3files#search'
  get 's3files/search_result', to: 's3files#search_result'
  post 's3files/:id/change_good_or_bad', to: 's3files#change_good_or_bad'
  resources :s3files do
    resources :comments, only: [:create, :update, :destroy]
  end
  resources :sessions, only: %i[create]
end
