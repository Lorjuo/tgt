# http://stackoverflow.com/questions/19781163/refactoring-a-large-routes-rb-file-in-rails-4
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end


TgtRefurbished::Application.routes.draw do

  # Includes

  draw :devise
  draw :carnival
  draw :elfinder
  draw :images
  draw :departments


  # Announcements
  resources :announcements


  # Messages
  resources :messages, :only => :index do
    member do
      get :images
    end
  end


  # Links
  resources :links, :only => [] do
    post :rebuild, :on => :collection # required for Sortable GUI server side actions
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


  # Users
  resources :users


  # Static Pages
  resources :static_pages, :only => [] do
    collection do
      get :home
      get :page_layout
      get :media_box
    end
  end


  # Trainers
  resources :trainers
  
  
  # Root
  root :to => "static_pages#home"
end
