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
      get :add_subject
      get :delete_member
      get :delete_subject
    end
    member do
      get :member_remaining
      get :subject_remaining
    end
  end
  resources :subjects, only: %i(index show)

  namespace :basic_trainee do
    resources :users do
      member do
        get :show_profile
      end
    end

    resources :courses, only: :show
  end
end
