Flitter::Application.routes.draw do

  devise_for :users
  resource :flits

  root :to => 'home#index'
  match '/following', :controller => 'home', :action => 'following', :as => 'following'
  match '/search', :controller => 'home', :action => 'search', :as => 'search'
  match '/remove_friend/:user_name', :controller => 'home', :action => 'remove_friend', :as => 'remove_friend'
  get '/:username', :controller => 'home', :action => 'show', :as => 'user_flits'
  match '/:username/toggle_follow', :controller => 'home', :action => 'toggle_follow', :as => 'toggle_follow'
  match '/:username/toggle_follow_via_ajax', :controller => 'home', :action => 'toggle_follow_via_ajax', :as => 'toggle_follow_via_ajax'

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
