Rails.application.routes.draw do


  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check
  root "feed#photo"
  get "/authenticate/login", to: "authentication#login"
  get "/authenticate/signup", to: "authentication#signup"
  get "/feed/album", to: "feed#album"
  get "/discover/photo", to: "discover#photo"
  get "/discover/album", to: "discover#album"
  get "/articles", to: "articles#index"
  put "/discover/follow", to: "discover#follow", as: :follow, defaults: { format: :json }
  get "/personal_info/photo/:id", to: "personal_info#photo", as: :personal_info_photo
  get "/personal_info/album/:id", to: "personal_info#album", as: :personal_info_album
  get "/personal_info/following/:id", to: "personal_info#following", as: :personal_info_following
  get "/personal_info/follower/:id", to: "personal_info#follower", as: :personal_info_follower
  # post "/react_photo", to: "react_photos#create"
  # delete "/react_photo", to: "react_photos#destroy"
  # post "/react_album", to: "react_albums#create"
  # delete "/react_album", to: "react_albums#destroy"
  put "/react_photos", to: "react_photos#handle_like", as: :react_photo, defaults: { format: :json }
  put "/react_albums", to: "react_albums#handle_like", as: :react_album, defaults: { format: :json }
  scope module: 'users' do
    resources :photos, :albums
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
