  # Carnival

  #get "carnival/orders/steps", to: "carnival/order_steps#personal_information", via: "post"
  get '/carnival/orders/steps(.:format)', :to => "carnival/order_steps#create", via: "post"
  namespace :carnival do
    resources :reservations
    resources :orders, :only => [] do
      resources :steps, controller: 'order_steps'#, :only => []
    end
    resources :categories
    resources :sessions
  end