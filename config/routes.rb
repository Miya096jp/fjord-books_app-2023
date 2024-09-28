Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/show'
  get 'reports/edit'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show)
  resources :reports
end
