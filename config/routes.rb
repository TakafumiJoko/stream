Rails.application.routes.draw do
  root 's3files#index'
  resources :users do
    resources :channels
  end
  resources :s3files
  resources :comments
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  resources :sessions, only: %i[create destroy]
end
