Rails.application.routes.draw do
  resources :holes
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }, 
                   path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :rounds do
    resources :holes
  end
  resources :championships do
    post 'join', on: :member
  end

  resources :teams do
    post 'join', on: :member
    delete 'leave', on: :member
    post 'start_round', on: :member 
  end

  resources :rounds do
    post 'add_hole', on: :member
    delete 'remove_last_hole', on: :member
  end
  
  root "home#index"
end
