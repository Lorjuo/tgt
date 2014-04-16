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

  #resources :events, :only =>:index



  # Announcements
  
  resources :announcements



  # Messages

  resources :messages, :only =>:index



  # Images

  resources :images do
    get :edit_multiple, on: :collection
    post :update_multiple, on: :collection
    get :crop, on: :member
  end


  # Links
  
  resources :links, :only => [] do
    collection do
      # required for Sortable GUI server side actions
      post :rebuild
    end
  end



  # Locations
  
  resources :locations do
    # Gmaps4RailsDisabled:
    # collection do
    #   get :interactive_map
    # end
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



  # Departments

  resources :departments, :only =>:index
  resources :departments, :shallow => true, :except =>:index do #, :path => ""
  #resources :departments, :shallow => true do
    member do
      get :training_groups
      get :galleries
      get :trainers
      get :messages
      get :documents
      get :events
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
    resources :events
    resources :messages
    resources :training_groups#, :only => [:new, :create]


    resources :links, :only => [:index, :show, :edit, :destroy] do
      get :sort, :on => :collection
    end
    scope :module => "linkable" do
      resources :extern_links
      resources :media_links do
        get :change_controller, :on => :collection
      end
      resources :pages
      resources :placeholders
    end
  end




  # Devise
  
  devise_for :users, path: "auth", :controllers => { :registrations => "authentication/registrations" }
  devise_scope :user do
    get "auth/show", :to => "authentication/registrations#show", :as => "user_registration_path"
  end



  # Documents
  # 
  #resources :documents, :only =>:index




  # Users
  
  # Set scope admin to differentiate between devise and custom user administration
  #scope "/admin" do
    resources :users
  #end



  # Static Pages
  
  resources :static_pages, :only => [] do
    collection do
      get :home
      get :page_layout
      get :media_box
    end
  end



  # Elfinder

  resources :elfinder, :only => [] do
    get 'backend', :on => :collection
    post 'backend', :on => :collection
    get 'frontend', :on => :collection
    get 'frontend_wrapper', :on => :collection
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
