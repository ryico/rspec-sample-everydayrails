Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  devise_scope :user do
    get "user/id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end

  resources :projects do
    resources :notes
    resources :tasks do
      member do
        post :toggle
      end
    end
  end

  namespace :api do
    resources :projects
  end

  root 'home#index'
end
