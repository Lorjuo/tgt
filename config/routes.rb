# http://stackoverflow.com/questions/19781163/refactoring-a-large-routes-rb-file-in-rails-4
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end


TgtRefurbished::Application.routes.draw do


  # Announcements
  resources :announcements


  # Messages
  resources :messages, :only => :index do
    get :images, :on => :member
  end


  # Links
  resources :links, :only => [] do
    post :rebuild, :on => :collection # required for Sortable GUI server side actions
    get :theme, :on => :member # Maybe move to linkable - usure
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


  # Includes
  # Has to be after the other includes, because it overrides some special routes

  draw :devise
  draw :carnival
  draw :elfinder
  draw :images
  draw :departments
  
  # Root
  root :to => "static_pages#home"
end
