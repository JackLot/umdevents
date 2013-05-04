Umdevents::Application.routes.draw do

  get "reminder/new"

  get "event_reminders/new"
  get "password_resets/new"

  resources :events_controller
  resources :users_controller
  resources :password_resets
  resources :reminder
  resources :sessions, :only => [:new, :create, :destroy]
  resources :calendar, :only => [:show, :addtocal]

  resources :calendar do
    member do
      get 'export'
    end
  end

  resources :events_controller do
    member do
      get 'export'
    end
  end

  get "users_controller/new"
  get "events_controller/show"
  get "calendar/show"
  get "events_controller/search"
  get "events_controller/tag"
  match "events_controller/approve_event", :to => 'events_controller#approve_event'

  root :to => 'events_controller#index'

  match '/submit_event', :to => 'events_controller#new'
  match '/signup', :to => 'users_controller#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy', via: :delete
  match '/mycalendar', :to => 'calendar#show'
  match '/events_controller/search', :to => 'events_controller#search'
  match '/events_controller/tag', :to => 'events_controller#tag'
  match '/user/profile', :to => 'users_controller#show'
  match '/resetpassword', :to => 'password_resets#new'
  match '/moderate-events', to: 'events_controller#moderate'

  match '/events/:id', :to => 'events_controller#show', :as => :event
  match '/events/:id/export', :to => 'events_controller#export'
  match '/calendar/:id', :to => 'calendar#addtocal'
  match '/calendar/:id/export', :to => 'calendar#export'


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
  #root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
