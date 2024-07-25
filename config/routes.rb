Rails.application.routes.draw do


  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check
  root "photos#feed"
  # get "/authenticate/login", to: "authentication#login"
  # get "/authenticate/signup", to: "authentication#signup"
  # get "/feed/album", to: "feed#album"
  # get "/discover/photo", to: "discover#photo"
  # get "/discover/album", to: "discover#album"
  # get "/articles", to: "articles#index"
  # put "/discover/follow", to: "discover#follow", as: :follow
  # get "/personal_info/photo/:id", to: "personal_info#photo", as: :personal_info_photo
  # get "/personal_info/album/:id", to: "personal_info#album", as: :personal_info_album
  # get "/personal_info/following/:id", to: "personal_info#following", as: :personal_info_following
  # get "/personal_info/follower/:id", to: "personal_info#follower", as: :personal_info_follower
  # get "/users/edit/:id", to: "users#edit", as: :edit_user
  #patch "/users/update/:id", to: "users#update", as: :update_user
  devise_scope :user do
    put "/users/update/:id", to: "devise/registrations#update_name", as: :update_user
  end
  # get "/users", to: "users#index", as: :users
  # delete "/users/delete/:user_id", to: "users#destroy", as: :delete_user
  # # post "/react_photo", to: "react_photos#create"
  # # delete "/react_photo", to: "react_photos#destroy"
  # # post "/react_album", to: "react_albums#create"
  # # delete "/react_album", to: "react_albums#destroy"
  # put "/react_photos", to: "react_photos#handle_like", as: :react_photo
  # put "/react_albums", to: "react_albums#handle_like", as: :react_album
  # scope module: 'users' do
  #   resources :photos, :albums
  # end

  
  # scope module: 'users' do
  #   resources :photos, :albums
  # end
  resources :users
  get "/users/:user_id/followings", to: "follows#followings", as: :followings
  get "/users/:user_id/followers", to: "follows#followers", as: :followers
  post "/follow", to: "follows#create", as: :follow_user
  delete "/unfollow", to: "follows#destroy", as: :unfollow_user
  get "/photos/discover", to: "photos#discover", as: :discover_photo
  get "/photos/feed", to: "photos#feed", as: :feed_photo
  get "/albums/discover", to: "albums#discover", as: :discover_album
  get "/albums/feed", to: "albums#feed", as: :feed_album
  get "/follow_button/user/:user_id", to: "follows#follow_button", as: :follow_button
  get "/unfollow_button/user/:user_id", to: "follows#unfollow_button", as: :unfollow_button

  post "/react_photos", to: "react_photos#create", as: :react_photo
  delete "/unreact_photos", to: "react_photos#destroy", as: :unreact_photo
  get "/react_photo_button/photo/:photo_id", to: "react_photos#react_button", as: :react_photo_button
  get "/unreact_photo_button/photo/:photo_id", to: "react_photos#unreact_button", as: :unreact_photo_button

  post "/react_albums", to: "react_albums#create", as: :react_album
  delete "/unreact_albums", to: "react_albums#destroy", as: :unreact_album
  get "/react_album_button/album/:album_id", to: "react_albums#react_button", as: :react_album_button
  get "/unreact_album_button/album/:album_id", to: "react_albums#unreact_button", as: :unreact_album_button

 
  

  # refactoring code
  resources :users, shallow: true do
    resources :photos, :albums
  end

  # routes for admin
  get "/admin/manage_users", to: "admins#manage_users", as: :manage_users
  get "/admin/manage_photos", to: "admins#manage_photos", as: :manage_photos
  get "/admin/manage_albums", to: "admins#manage_albums", as: :manage_albums
  get "/admin/edit_user/:id", to: "admins#edit_user", as: :admin_edit_user
  # Defines the root path route ("/")
  # root "posts#index"
end
