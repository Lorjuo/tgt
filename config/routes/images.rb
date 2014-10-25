  # Images

  resources :images do
    get :edit_multiple, on: :collection
    post :update_multiple, on: :collection
  end

  # namespace :image do # Works but the path is long
  scope as: 'image' do # Works with short paths
    resources :banners, controller: 'images', type: 'Image::Banner'#, except: %i(new edit)
    resources :headers, controller: 'images', type: 'Image::Header'#, except: %i(new edit) 
    resources :posters, controller: 'images', type: 'Image::Poster'#, except: %i(new edit)
  end

  concern :imageable do
    resources :images
  end