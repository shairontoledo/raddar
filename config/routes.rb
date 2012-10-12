Raddar::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :pages, only: [:show]

  resources :tags, only: [:show]

  resources :newsletters, only: [:show]

  resources :venues, only: [:index, :show, :new, :create] do
    resources :comments, only: [:create]
    resource :watching, only: [:destroy] do
      get 'unwatch' => 'watchings#destroy'
    end
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
    resources :comments, only: [:create]
    resource :watching, only: [:destroy] do
      get 'unwatch' => 'watchings#destroy'
    end
    resource :vote, only: [:create]
  end

  resources :comments, only: [:destroy] do
    resource :vote, only: [:create]
  end

  resources :forums, only: [:index, :show] do
    resources :topics, except: [:index] do
      resources :posts, only: [:create]
    end
    resources :followers, only: [:create, :index] do
      delete 'destroy', on: :collection
    end 
  end

  resources :posts, only: [:destroy] do
    resource :vote, only: [:create]
  end

  resources :topics, only: [] do
    resource :watching, only: [:destroy] do
      get 'unwatch' => 'watchings#destroy'
    end
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
    resources :newsletters, except: [:show] do
      put 'send_now', on: :member
    end
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
    get '/users/registrations/destroy' => 'users/registrations#destroy', as: :destroy_user_registration
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

Raddar::Application.routes.named_routes.module.module_eval do
  def raddar_path resource, options = {}
    case resource.class.name.underscore.to_sym
    when :comment
      options[:anchor] = 'comments'
      raddar_path resource.commentable, options
    when :post
      options[:post_id] = resource.id
      options[:anchor] = "post_#{resource.id}"
      raddar_path resource.topic, options
    when :stuff
      pub_stuff_path resource.pub, resource, options
    when :topic
      forum_topic_path resource.forum, resource, options
    else
      send "#{resource.class.name.underscore}_path".to_sym, resource, options
    end
  end

  def raddar_url resource, options = {}
    options[:only_path] = false unless options.key? :only_path

    raddar_path resource, options
  end
end