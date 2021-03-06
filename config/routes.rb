Rails.application.routes.draw do

  resources :search_suggestions
  resources :trips do
    resources :locations      
  end
  
  resources :locations do
    resources :interests, :photos, :tips  
  end
  resources :activities, :photos, :tips, :searches
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'} 
  resources :users do
    member do
      get :friends
      get :followers
      get :deactivate
      get :mentionable
    end
  end
  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  root :to => 'trips#index'
  # get '/users/:id', :to => 'users#show', :as => :user
  # get '/users/:id', :to => 'users#friends', :as => :user
  # get '/users/:id', :to => 'users#followers', :as => :user
  get :my_trips, to: 'trips#my_trips'
  get :add_location, to: 'trips#add_location'
  get :add_tip, to: 'locations#add_tip'
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  get 'sign_in', :to => 'users/sessions#new', :as => :new_session
  resources :users, only: [:index]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
