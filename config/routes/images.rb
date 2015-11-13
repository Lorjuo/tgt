  # Images

  concern :croppable do
    get :crop, on: :member
    get :update_crop, on: :member
  end

  # namespace :image do # Works but the path is long
  #scope :module => 'image' do # Works with short paths
  #scope as: 'image' do # Works with short paths
    resources :banners, controller: 'images', type: 'Image::Banner', concerns: [:croppable]#, except: %i(new edit)
    resources :headers, controller: 'images', type: 'Image::Header', concerns: [:croppable]#, except: %i(new edit) 
    resources :home_cycle_images, controller: 'images', type: 'Image::HomeCycleImage', concerns: [:croppable]#, except: %i(new edit) 
    resources :posters, controller: 'images', type: 'Image::Poster', concerns: [:croppable]#, except: %i(new edit)
    resources :photos, controller: 'images', type: 'Image::Photo', concerns: [:croppable]#, except: %i(new edit)
    #resources :gallery_images, controller: 'images', type: 'Image::GalleryImage' do #, concerns: [:croppable]#, except: %i(new edit)
    resources :gallery_images, module: 'image', concerns: [:croppable] do
      get :edit_multiple, on: :collection
      post :update_multiple, on: :collection
    end
  #end

  concern :imageable do
    resources :images
  end