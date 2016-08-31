Rails.application.routes.draw do
  devise_for :users, controllers:{ registrations: 'registrations',  omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'places#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :bookings, only: [:new, :create, :edit, :update, :destroy]
    resources :whitelists, only: [:new, :create, :destroy, :index]

  end

  resources :bookings, only: [:index, :destroy]

  resources :invites, only: [:show, :update]

  mount Attachinary::Engine => "/attachinary"

  get '/:friendly_id', to: 'places#show', :as => :friendly_place
end
