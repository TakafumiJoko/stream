Rails.application.routes.draw do
  root 'videos#home'
  resources :users do
    resources :channels
  end
  get 'videos/home', to: 'videos#home'
  get 'videos/category', to: 'videos#category'
  post 'videos/search', to: 'videos#search'
  get 'videos/search_result', to: 'videos#search_result'
  post 'videos/:id/change_good_or_bad', to: 'videos#change_good_or_bad', as: :videos_change_good_or_bad
  resources :videos do
    resources :comments, only: [:create, :update, :destroy]
  end
  resources :sessions, only: [:create, :destroy]
end
