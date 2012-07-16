TalentDrivenDevelopment::Application.routes.draw do
  
  # Only allow agent and talent types for new registration, otherwise route to welcome#index
  devise_scope :user do 
    get "users/sign_up/:type" => "registrations#new", :as => :new_user_registration, :type => /agent|talent/
    get "users/sign_up/:type" => "welcome#index", :as => :new_user_registration
  end
  
  # Devise routes and custom devise controllers
  devise_for :users, :controllers => {:registrations => "registrations", :confirmations => "confirmations"}

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
  
  # User resources including resources for user types
  resources :users 
  resources :agents, :controller => 'users' do
    resources :requests, :only => :new
  end
  get 'agents/:user_id/dashboard' => 'dashboards#show', :as => :agent_dashboard

  resources :talents, :controller => 'users'
  get 'talents/:user_id/dashboard' => 'dashboards#show', :as => :talent_dashboard
  
  resources :requests 
  resources :notifications
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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
