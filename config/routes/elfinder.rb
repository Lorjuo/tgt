  # Elfinder

  resources :elfinder, :only => [] do
    get 'backend', :on => :collection
    post 'backend', :on => :collection
    get 'frontend', :on => :collection
    get 'frontend_wrapper', :on => :collection
  end