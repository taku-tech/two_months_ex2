Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about' => 'home#about'
  resources :users,only: [:show,:index,:edit,:update] do
  	resources :relationships,only: [:index,:create,:destroy]
  end
  resources :books,except: [:new] do
  	resources :book_comments,only: [:create, :destroy]
  	resource :favorites,only: [:create,:destroy]
  end
end
