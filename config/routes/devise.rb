  # Devise
  
  devise_for :users, path: "auth", :controllers => { :registrations => "authentication/registrations" }
  devise_scope :user do
    get "auth/show", :to => "authentication/registrations#show", :as => "show_user_registration"
  end