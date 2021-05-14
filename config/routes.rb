Rails.application.routes.draw do
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
end
