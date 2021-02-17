Rails.application.routes.draw do
  root to: 'articles#index'

  resources :articles do
    collection do
      get 'search'
    end
  end

  resources :users do
    collection do
      get 'validate_email'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
