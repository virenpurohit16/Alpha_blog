Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
<<<<<<< HEAD
  resources :articles
=======
  resources :articles, only: [:show, :index, :new, :create]
>>>>>>> parent of 79f0498... Enabling editing and updating of existing articles
end
