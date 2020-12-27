Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tasks#todo"

  resources :tasks do
    resource :outputs, only: [:show, :edit, :update]
    collection do
      get :done
    end
  end
  resources :recommends
  
  resource :user
end
