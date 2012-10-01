Raddar::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :pages, only: [:show]

  resources :tags, only: [:show]

  resources :venues, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create, :destroy]
    resource :watching, only: [:destroy]
    resource :vote, only: [:create]
    get 'nearby', on: :collection
  end

  resources :notifications, only: [:show, :index, :destroy] do
    post 'read', on: :collection
  end

  resources :universes, only: [:show]

  resources :pubs do
    resources :stuffs, except: [:index]
    resources :followers, only: [:create, :index] do
      delete 'destroy', on: :collection
    end 
  end

  resources :stuffs, only: [] do
    resources :comments, only: [:create, :destroy]
    resource :watching, only: [:destroy]
    resource :vote, only: [:create]
  end

  resources :comments, only: [] do
    resource :vote, only: [:create]
  end

  resources :forums, only: [:index, :show] do
    resources :topics, except: [:index] do
      resources :posts, only: [:create, :destroy]
      #resource :watching, only: [:destroy]
    end
    resources :followers, only: [:create, :index] do
      delete 'destroy', on: :collection
    end 
  end

  resources :posts, only: [] do
    resource :vote, only: [:create]
  end

  resources :topics, only: [] do
    resource :watching, only: [:destroy]
  end

  namespace 'admin' do
    root to: 'home#index'
    resources :users, only: [:index, :edit, :update]
    resources :pubs, only: [:index, :destroy] do
      member do
        put 'set_main'
        put 'remove_main'
      end
    end
    resources :forums, except: [:show]
    resources :venues, except: [:show, :new, :create]
    resources :universes, except: [:show] do
      resources :ranks, except: [:show]
    end
    resources :pages, except: [:show]
  end

  namespace 'users', as: 'user' do
    resource :privacy, controller: 'privacy', only: [:edit, :update]
    resources :accounts, only: [:index, :destroy]
    resource :notifications, only: [:edit, :update] do
      post 'read', on: :collection
    end
  end

  devise_for :users, :controllers => {omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations", passwords: 'users/passwords' }
  devise_scope :user do
    get '/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/users/password/change' => 'users/passwords#change', as: :change_user_password
    put '/users/password/change' => 'users/passwords#do_change', as: :change_user_password
  end

  resources :users, only: [:show] do
    resources :messages, only: [:index,:create] do
      collection do
        delete 'destroy_all'
        get 'more'
        post 'read'
      end
    end
    resources :followers, only: [:create, :index] do
      delete 'destroy', on: :collection
    end
    resources :followees, controller: 'users/followees', only: [:index]
  end

  resources :messages, only: [:index] do
    post 'read', on: :collection
  end

  get 'search' => 'home#search', as: :search

  resources :contacts, only: [:new, :create]

  root to: 'home#index'

  match '/404', to: 'home#exception'
  match '/422', to: 'home#exception'
  match '/500', to: 'home#exception'

end