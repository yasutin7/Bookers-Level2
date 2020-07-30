Rails.application.routes.draw do
  get 'home/top'
  get 'home/about'
  devise_for :users
  resources :users
  resources :books
  root to: 'home#top'
  get '/home/about' => 'home#about'
end
