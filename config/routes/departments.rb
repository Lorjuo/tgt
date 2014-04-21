  # Departments

  resources :departments, :only =>:index
  resources :departments, :shallow => true, :except =>:index do #, :path => ""
    member do
      get :images
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
      concerns :imageable
      # scope :module => "image" do
      #   resources :images
      # end
      member do
        post :set_preview_image
      end
      #resources :images
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