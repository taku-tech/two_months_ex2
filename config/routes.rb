Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
  	resources :books,except: [:new]
  end
  root 'home#top'
  get 'home/about'
end
