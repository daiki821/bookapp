Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tasks#todo"

  resources :tasks do
    collection do
      get :todo, :done
    end
  end
  resources :completed_tasks, only: [:index, :show]
  resource :user
end
