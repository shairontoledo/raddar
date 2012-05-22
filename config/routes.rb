Raddar::Application.routes.draw do

  namespace 'admin' do
    get "/" => 'home#index', as: :root
  end

  namespace 'users', as: 'user' do
    resource :privacy, controller: 'privacy', only: [:edit, :update]
    resources :accounts, except: [:edit, :update, :show]
  end

  devise_for :users, :controllers => {omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations", passwords: 'users/passwords' } do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/users/password/change' => 'users/passwords#change', as: :change_user_password
    put '/users/password/change' => 'users/passwords#do_change', as: :change_user_password
  end

  get 'search' => 'home#search', as: :search

  resources :users, except: [:new,:create,:destroy] do
    resources :messages, only: [:index,:create] do
      collection do
        delete 'destroy_all'
        get 'more'
      end
    end
  end
  get 'messages' => 'messages#all', as: :all_messages

  root :to => 'home#index'

end