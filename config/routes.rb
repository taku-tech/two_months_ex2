Rails.application.routes.draw do
  resources :users,only: [:show,:index,:edit,:update] do
  	resources :books,except: [:new]
  end
  devise_for :users
  root 'home#top'
  get 'home/about'
end
