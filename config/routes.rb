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

  resources :users, except: :show
  get 'users/:name' => 'users#show', as: :user

  root :to => 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
