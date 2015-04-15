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
      #scope 'image', module: 'image', as: 'image' do
      #scope :module => 'image' do # Works with short paths
      #scope :image do # Works with short paths
      #namespace :image do # Works with short paths
        resources :gallery_photos, :module => 'image', path: 'photos'#, as: 'photos'
        # renaming of route without renaming model does not work because url helper only looks for model names
        #resources :photos, :controller=>"gallery_photos", :module => 'image', path: 'photos'
      #end
      # concerns :imageable
      # scope :module => "image" do
      #   resources :images
      # end
      member do
        post :set_preview_photo
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