Rails.application.routes.draw do
  root "courses#index"

  devise_for :users

  resources :users do
    member do
      get :show_profile
    end
  end

  scope module: :users do
    resources :users
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
      get :start
    end
  end
  resources :subjects, only: %i(index show) do
    resources :tasks, except: %i(index show)
  end

  namespace :basic_trainee do
    root "users#index"
    resources :users do
      member do
        get :show_profile
      end
    end

    resources :courses, only: :show do
      resources :subjects, only: :show do
        member do
          get :start_task
          get :finish_task
          get :finish_subject
        end
      end
    end
  end
  namespace :basic_trainee do
    resources :users
  end

  # scope module: 'basic_trainee' do
  #   resources :users
  # end

  # namespace prefix add name_namespace to resouces
end
