Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  post '/tasks/:id/done' => 'tasks#done', as: 'done'

  resources :tasks do
    resource :outputs, only: [:show, :edit, :update]
    collection do
      get :finish
      get :todo
    end
  end
  resources :recommends do
    resource :like, only: [:show, :create, :destroy]
    resources :comments, only: [:index, :new, :create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    resources :favorite, only: [:index]
  end

  resource :user do
    resources :favorite, only: [:index]
  end
end
