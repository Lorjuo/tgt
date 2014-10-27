  # Images

  resources :images do
    get :edit_multiple, on: :collection
    post :update_multiple, on: :collection
  end

  concern :croppable do
    get :crop, on: :member
  end

  # namespace :image do # Works but the path is long
  scope as: 'image' do # Works with short paths
    resources :banners, controller: 'images', type: 'Image::Banner', concerns: [:croppable]#, except: %i(new edit)
    resources :headers, controller: 'images', type: 'Image::Header', concerns: [:croppable]#, except: %i(new edit) 
    resources :posters, controller: 'images', type: 'Image::Poster', concerns: [:croppable]#, except: %i(new edit)
  end

  concern :imageable do
    resources :images
  end