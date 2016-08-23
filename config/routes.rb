Rails.application.routes.draw do
  devise_for :users
  root to: 'places#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places
end
