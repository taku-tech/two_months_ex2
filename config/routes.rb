Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books,except: [:new] do
  	resource :favorite,only: [:create,:destroy]
  end
end
