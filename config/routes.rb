TgtRefurbished::Application.routes.draw do


  # Carnival

  #get "carnival/orders/steps", to: "carnival/order_steps#personal_information", via: "post"
  get '/carnival/orders/steps(.:format)', :to => "carnival/order_steps#create", via: "post"
  namespace :carnival do
    resources :reservations
    resources :orders, :only => [] do
      resources :steps, controller: 'order_steps'#, :only => []
    end
    resources :categories
    resources :sessions
  end



  # Events

  resources :events



  # Announcements
  
  resources :announcements



  # Messages

  resources :messages, :only =>:index



  # Pages

  resources :pages



  # Images

  resources :images do
    get :edit_multiple, on: :collection
    post :update_multiple, on: :collection
  end



  # Locations
  
  resources :locations do
    collection do
      get :interactive_map
    end
    member do
      get :schedule
    end
  end



  # TrainingUnits
  
  resources :training_units



  # TrainingGroups

  resources :training_groups, :only => :index do
    get :search, on: :collection
  end



  # NavigationElements

  resources :navigation_elements, :only => [] do
    collection do
      # required for Sortable GUI server side actions
      post :rebuild
    end
  end



  # Departments

  resources :departments, :only =>:index
  resources :departments, :shallow => true, :except =>:index do #, :path => ""
  #resources :departments, :shallow => true do
    member do
      get :training_groups
      get :galleries
      get :trainers
      get :messages
      get :sort_navigation_elements
      get :flyers
      # required for Sortable GUI server side actions
      post :rebuild
    end

    # Nested Resources
    
    resources :documents
    resources :galleries, :shallow => true do
      member do
        post :set_preview_image
      end
      resources :images
    end
    resources :messages
    resources :training_groups#, :only => [:new, :create]
    resources :navigation_elements do
      collection do
        # get :sort

        # required for Sortable GUI server side actions
        # post :rebuild
        get :change_controller
      end
    end
  end
  resources :documents, :only =>:index



  # Devise
  
  devise_for :users



  # Users
  
  # Set scope admin to differentiate between devise and custom user administration
  scope "/admin" do
    resources :users
  end



  # Static Pages
  
  resources :static_pages, :only => [] do
    collection do
      get :home
      get :page_layout
    end
  end



  # Elfinder

  resources :elfinder, :only => [] do
    get 'backend', :on => :collection
    post 'backend', :on => :collection
    get 'frontend', :on => :collection
  end
  


  # Trainers
  
  resources :trainers
  # resources :trainers, :only =>:index
  # resources :trainers, :shallow => true, :except =>:index
  
  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root :to => "static_pages#home"

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
