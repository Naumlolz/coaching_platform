Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#main'

  get '/sign_in', to: 'sessions#sign_in'
  get '/sign_up', to: 'sessions#sign_up'

  get '/users/sign_in', to: 'sessions#user_sign_in'
  post '/users/sign_in', to: 'sessions#user_perform_sign_in'
  get '/coaches/sign_in', to: 'sessions#coach_sign_in'
  post '/coaches/sign_in', to: 'sessions#coach_perform_sign_in'

  get '/users/sign_up', to: 'sessions#user_sign_up'
  post '/users/sign_up', to: 'sessions#user_perform_sign_up'
  get '/coaches/sign_up', to: 'sessions#coach_sign_up'
  post '/coaches/sign_up', to: 'sessions#coach_perform_sign_up'

  get '/sign_out', to: 'sessions#sign_out'

  get '/users/dashboard', to: 'users#dashboard'
  get '/coaches/dashboard', to: 'coaches#dashboard'

  get '/users/finish_profile', to: 'users#finish_profile'
  post '/users/finish_user_profile', to: 'users#finish_user_profile'

  get '/coaches/finish_profile', to: 'coaches#finish_profile'
  post '/coaches/finish_coach_profile', to: 'coaches#finish_coach_profile'

  get '/users/profile', to: 'users#profile'
  post '/users/update_profile', to: 'users#update_profile'
  get '/coaches/profile', to: 'coaches#profile'
  post '/coaches/update_profile', to: 'coaches#update_profile'

  get '/users/change_password', to: 'users#change_password'
  post '/users/update_password', to: 'users#update_password'
  get '/coaches/change_password', to: 'coaches#change_password'
  post '/coaches/update_password', to: 'coaches#update_password'

  get '/users/all_coaches', to: 'users#all_coaches'
  post '/users/invite_coach', to: 'users#invite_coach', as: :invite_coach
  post '/users/unassign_coach', to: 'users#unassign_coach'

  get '/coaches/my_users', to: 'coaches#my_users'
  get '/coaches/waiting_for_confirmation', to: 'coaches#waiting_for_confirmation'
  post '/coaches/accept_invite', to: 'coaches#accept_invite'
  post '/coaches/decline_invite', to: 'coaches#decline_invite'

  resources :user_techniques, only: [:index]
  resources :user_programs, only: %i[index update]
  resources :coach_programs, only: [:index]
  resources :user_messages, only: %i[index create]
  resources :coach_messages, only: %i[index create]
  resources :steps, only: [:show] do
    member do
      post 'perform_complete'
    end
    collection do
      post 'restart'
    end
  end
  resources :coaches do
    collection do
      post 'update_expertise'
    end
  end

  resources :users do
    collection do
      get 'forget_password'
    end
  end

  namespace :passwords do
    resource :send_code, only: [:create]
    resource :validate_code, only: %i[create show]
    resource :set_new_password, only: %i[create show]
  end

  namespace :users_programs_ratings do
    resource :rating, only: [:create]
  end

  mount ActionCable.server => '/cable'
end
