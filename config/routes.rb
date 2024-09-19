Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  root to: "books#index"
  devise_for :users
  resources :users, only: [:index, :show]
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
