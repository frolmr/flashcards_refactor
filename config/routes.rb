Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  filter :locale

  root 'main#index'

  scope module: 'home' do
    resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]
    get 'login' => 'user_sessions#new', :as => :login

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    resources :user_sessions, only: :destroy
    resources :users, only: :destroy
    post 'logout' => 'user_sessions#destroy', :as => :logout

    resources :cards

    put 'find_flickr_images' => 'cards#find_on_flickr'

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    put 'review_card' => 'trainer#review_card'
    get 'trainer' => 'trainer#index'

    get 'profile/:id/edit' => 'profile#edit', as: :edit_profile
    put 'profile/:id' => 'profile#update', as: :profile
  end
end
