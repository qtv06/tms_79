Rails.application.routes.draw do
  root "static_pages#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


  resources :users do
    member do
      get :show_profile
    end
  end
  resources :courses do
    collection do
      get :add_member
    end
    member do
      get :member_remaining
    end
  end

  namespace :basic_trainee do
    resources :users
  end
end
