TgtRefurbished::Application.routes.draw do

  resources :announcements

  resources :pages

  resources :messages

  resources :documents

  resources :images

  resources :galleries, :shallow => true do
    resources :images
  end

  resources :locations

  resources :trainers

  resources :training_units

  #resources :training_groups

  resources :navigation_elements, :only => [] do
    collection do
      # required for Sortable GUI server side actions
      post :rebuild
      get :change_controller
    end
  end

  resources :departments, :only =>:index
  resources :departments, :shallow => true, :except =>:index do #, :path => ""
  #resources :departments, :shallow => true do
    member do
      get :training_groups
      get :sort_navigation_elements
      # required for Sortable GUI server side actions
      post :rebuild
    end
    resources :training_groups#, :only => [:new, :create]
    resources :navigation_elements do
      collection do
        # get :sort

        # required for Sortable GUI server side actions
        # post :rebuild
        # get :updated_controller
      end
    end
  end


  devise_for :users
  # Set scope admin to differentiate between devise and custom user administration
  scope "/admin" do
    resources :users
  end

  resources :static_pages, :only => [] do
    get :home, :on => :collection
  end

  resources :elfinder, :only => [] do
    get 'backend', :on => :collection
    post 'backend', :on => :collection
    get 'frontend', :on => :collection
  end
  
  resources :trainers, :only =>:index
  resources :trainers, :shallow => true, :except =>:index

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
