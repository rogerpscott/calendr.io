Rails.application.routes.draw do
  devise_for :users, controllers:{ registrations: 'registrations' }
  root to: 'places#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :bookings, only: [:new, :create, :edit, :update]
    resources :whitelists, only: [:new, :create, :destroy, :index]

  end

  resources :bookings, only: [:index, :destroy]

  mount Attachinary::Engine => "/attachinary"

end
