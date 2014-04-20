  # Images

  resources :images do
    get :edit_multiple, on: :collection
    post :update_multiple, on: :collection
  end
  namespace :image do
    #scope :module => "image" do
    resources :banners do
      get :crop, on: :member
    end
    resources :images
  end

  concern :imageable do
    #scope :module => "image" do
    namespace :image do
      resources :images#, :only => [:new, :create]
    end
  end