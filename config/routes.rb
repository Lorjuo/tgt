# http://stackoverflow.com/questions/19781163/refactoring-a-large-routes-rb-file-in-rails-4
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end


# for scope, namespace, ... see:
# http://stackoverflow.com/questions/16757021/namespaced-apis-and-resource-routes
# http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Scoping.html
# http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Scoping.html#method-i-namespace
# http://notahat.com/2014/02/05/scoping-rails-routes.html
# 
# look also at: image.rb
TgtRefurbished::Application.routes.draw do

  resources :home_cycle_slides do
    collection { post :sort }
  end
  resources :quick_links do
    collection { post :sort }
  end
  resources :themes

  # Announcements
  resources :announcements do
    collection { post :sort }
  end


  # Messages
  resources :messages, :only => :index do
    get :images, :on => :member
    put :publish, :on => :member
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
      get :download_button
      get :row
    end
  end


  # Trainers
  resources :trainers


  # Datatables
  # # https://github.com/rweng/jquery-datatables-rails/issues/41
  # https://gist.github.com/ricardodovalle/7244900
  get 'datatable_i18n', to: 'datatables#datatable_i18n'


  # Includes
  # Has to be after the other includes, because it overrides some special routes

  draw :devise
  draw :carnival
  draw :elfinder
  draw :images
  draw :departments
  
  # Root
  root :to => "static_pages#home"

  


  resources :short_routes
  match ':name' => 'short_routes#redirect', :via => [:get]
end
